# Configuration
Search head
indexers
forwarders (distrubuted to all the indexers load balanced)

## Setting up
tasks
- all must used the license master
- indexes must all use the same app
- edit_user capability on all search peers (admin)
- splunk web can be used to add the peers
    - unless you are using clustering
INDEXER
- create admin role user
- all indexers must connect to the forwarders
- search head must talk to the indexers
    - in 8089 (splunkd communication)
    - `curl -k https://<search peer ip>:8089` (-k means insecure because its on the instance)
Add a PEER
- Go onto the Captain
    - settings/distrubuted search/search peers add new  
    - user must have edit_user or admin capabili
    - not needed with clustering
- Valdiate
    - run a search and check which peer ran the search
    - _internal web_access_log
    - GUI 
        - Health Status = Sick (or Healthy)

## Distrubuted Search Groups
search peers are configured into groups in:
distsearch.conf
- helps distrubuted load of specific searches
- cannot be used with clustering
    distsearch.conf
    [distributedSearch] (original)
    [distrubutedSearch:sec] (group)
    server = <ip address>
    [distrubutedSearch:sre] (another group)
    server = <ip address>

## Quarantining Search Peers
may not want a peer to be searching (d/t maintainance)
- searches not dispatched, but all conf are maintained

## DEMO
indexer 1 idx1
indexer 2 idx2
indexer 3 idx3
Search head sh1
forwarder fw1

ON THE SEARCH HEAD
distsearch.conf etc/system/local
[distrubutedSearch]
servers = <idx1 ip>,<idx2 ip>,<idx3 ip>

ON THE FORWARDER
how it sends to these three indexers
/opt/splunkforwarder/etc/system/local
outputs.conf
    [tcpout:idxGroup]
    servers = <idx1 ip>,<idx2 ip>,<idx3 ip>

inputs.conf
    [default]
    host = fw1
    [monitor:///var/log/messages]
    _TCP_ROUTING = idxGroup  (this group is set in the outputs.conf above)
    index = main
    sourcetype = syslog
    -gnoreOlderThan = 7d

Validate `index=_internal host=fw1`
    how to see splunkd on the forwarder

## Distrubuted search groups
searchhead
    distsearch.conf  splunk/etc/system/local
    [distributedSearch] (original, if no group specified)
    servers = <idx1 ip>,<idx2 ip>,<idx3 ip>
    [distrubutedSearch:sec] (group sec)
    servers = <idx1 ip>,<idx2 ip>
    default = false
    [distrubutedSearch:sre] (another sre)
    servers = <idx3 ip>
    default = false
HOW TO QUERY THIS
`index=main splunk_server_group = "sec"`

QUARANTINE
settings/distrubted search/search peer
    select quarantine
can force searching with
    `index=main splunk_server_group = *`