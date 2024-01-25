# Distrubuted Search
## About searches
Bloom Filter is a fast way to see if data is in a bucket using hashing
- bit array made from hashing algorithm
- bloom filter for each data bucket
- compares these two
- false possitives common, false negatives not possible

## Search Jobs
ad-hoc 10min
saved search    10min
schedulerd search   twice scheduled period
scehduled with eamil    24 hours
scheduled with script   10min
    limits.conf 
    ttl = 

## Enviroment
Machine data  => indexer <==    Search Head  
Process
- Search head recieves request
- dispaches to the peer
    - search peer runs the search
- search head merges results from all the peers
- runs transforming command

## Peers
- must be added in search heads
- with clustering peers are automatically added
- when a peer goes down its removed from the list 
    check every 10 seconds

## Knowledge Bundles
Archive of knowledege objects that search head sends to all search peers
- KO kept in the search head
- search peers do not know about these
- needed for the search though so the bundle is needed
- Bundle contains
    - Search Head
        - SPLUNK_HOME/var/run
            .bundle (full bundle)
            .delta (only changes)
    - Peers
        - SPLUNK_HOME/var/run/searchpeers/<bundleid>
            - system
            - users
            - apps
            - bundle.info
## Knowledge Bundle Replications
periodic distrubtion to peers
periodically replicates the bundle in the background
- Full bundle
- Delta (changes since the last full bundle push)
Replication Policy
- Classic (repilcates to all peers)
- Cascading (only subset of search peers--who replicate to the others) (large clusters are more efficient) 
- Mounted (search head places in a shared storage) (not recomended)
- RFS (remote file storage, s3 buckets)
Set on the search head in:
    disksearch.conf
    [replicatonSettings]
    replicationPolicy = [classic | cascading \ rfs \ mounted]
    connnectionTimeout = 60 
    maxBundleSize = 2048 (2k)

Customize what gets replicated
    distsearch.conf
    [replicatoinBlacklist]
    excludeLookups = apps/myapp/lookups/mybiglookup*  (some files need to be black listed)
Monitor this
    - Splunk Web Settings/Distrubted Search (must be on the captain to do this)
    - DMC Search/Distrubted search
    - CLI (must be on the captain)
        `SPLUNK_HOME/bin/splunk show bundle-replication-status`
    - REST API
    `/services/search/distrubuted/bundle/replication/config`

## DEMO
search log contains peer information
    - look for search context
LOOK FOR JOBS ON THE INSTANCE
- `SPLUNK_HOME/var/run/splunk/dispatch ls -lrt`
    drwx------  24 johnblalock  admin  768 Jan 25 13:46 1706219169.150 (this is the search sid, unix time)
    - Go into this sid `cd  1706219169.150`
        request.csv (has the full search string)
        results.srs.zst (commpressed can't read)
        args.txt (time to live)
    - This info is only kept for the lifetime of the job

