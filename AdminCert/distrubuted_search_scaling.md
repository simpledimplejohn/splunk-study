# Scaling distrubuted search
options for scaling
- independent search head
    - same search peers
    - isolate groups of users
        - access is controled by these search heads
- search head cluster (most common)
    - min 3
    - load balancer for the search heads
- indexer cluster
    - search heads can be in the indexer cluster...?
    - clustermaster automatically updates changes with indexers

## Search Head Cluster Architecture
- at least 3
- always use brand new instances
- members must have the same harware capacity
- synchronize the clocks between members and peers
    - NTP in unix

## CAPTAIN (not master)
- centreally coordinates cluster activites
- it's a member as well
- not a master/slave
- dynamic 
    - automatically elects a captain
- static
    - specific node
- more CPU
- Captain is the only scheduler 
    - all other members are disabled
- Captain choses search head 
    - assigns jobs based on load
- Search Artificats
    - schedule searches are replicated
    - ad-hoc and real time not replicated

## Configuration Managment
- automatic replication
    - splunk web
    - CLI
    - REST API 
- Deployer  (like a deployment server for forwarders)
    - for .conf files

## Deployer
- outside the cluster
- connects to cluster with pass4SymmKey in server.conf
- Apps /etc/shcluster/apps (these get deployed)
- merges default and local files, 
    - pushes to default directory of SHC member (never local)
- Automatically triggers rolling restart

## DEMO
initialize a cluster and selecting a cluster

Cluster
idx1
sh1
sh2
sh3
fw1

### Search Head initialization
run this on all the search heads
search head mgmt_uri is the server you are on, 
the secret is the pass4key
`cd /opt/splunk/bin`
`./splunk init shcluster-config -mgmt_uri http://172.31.25.141:8089 -replication_port 920 -secret shcluster`
`.splunk restart`

### form the cluster
This forms the cluster
And picks the captain
`./splunk boostrap shcluster-captain -server_list <ip1>,<ip2>,<ip3>`
Check the server.conf file:
    /etc/system/local
    vi server.conf
Check that its working
`./splunk show shcluster-status`
    Captain: 
    Members:

### Add search peer (indexer)
add to each search head
server.conf
    [raft_statmachine]
    disabled = false
    replicate_search_peers = true
and restart
run command
`./splunk add search-server https://172.31.27.192:8089 =remoteUsername shuser -remotePassword`
now data is abailble 