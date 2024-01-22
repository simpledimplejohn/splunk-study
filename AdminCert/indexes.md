# indexes

Data stored 
SPLUNK/var/lib/splunk
 - one lib per index
- Contain raw data and index files
- can be created by admin
- prebuilt indexes
     - _intneral
     - _audit
     - main

- Contain
     - Tsidx time series index files
     - RAW data
     - metadata
          - Sources.data
          - SourceTypes.data
          - Hosts.data
- Data Buckets
     - Organized by age
     - RAW Tsidx Metadata
     - Types
          - Hot
               - read/write
               - more than one
               - searchable
               - roll to warm on restart or nothing for 24 hours
          - Warm
               - rolled from hot
               - no writing
               - same dir as hot
               - roll to cold after settings
          - Cold
               - set time roll
               - diff directory
               - searchable
               - not writeable
               - can config directory (save money by storing somewhere else)
          - Frozen
               - retention rolls to frozen
               - delete is the default action
               - can be archived to a location
               - coldToFrozenDir or coldToFrozenScript
               - archived buckets are not searchable
          - Thawed
               - frozen buckets thawed
               - rebuilt to the index
               - no age restriction
               - `splunk rebuild command` must be run
     - location
          - SPLUNK_HOME/var/lib/splunk/myfirstindex/db/
          - SPLUNK_HOME/var/lib/splunk/myfirstindex/db/
          - SPLUNK_HOME/var/lib/splunk/myfirstindex/db/colddb/
          - frozen can be archived to a location
          - SPLUNK_HOME/var/lib/splunk/myfirstindex/db/thawddb
     - Bucket Naming
          - hot_v1_<local id> 
          - db_<newesttime>_<oldesttime>_<local id> (warm buckets)
          - /Applications/Splunk/var/lib/splunk/_introspection (introspection index)
               colddb			datamodel_summary	db			thaweddb

- Making indexes
     - roll based access, retention per index
     - security
          authorize.conf
               [role_myrole]
               srchIndexesAllowed = (list of indexes)
          indexes.conf
               [main]
               coldPath = (location)
               enableDataIntegrityControl (set to 1 to turn on)
               homePath = 
               maxTotalDataSizeMB = 
               frozentimePeriodInSecs = (older data gets deleted)
     splunk/etc/system/defualt/indexes.conf
          [main]
          homePath   = $SPLUNK_DB/defaultdb/db
          coldPath   = $SPLUNK_DB/defaultdb/colddb
          thawedPath = $SPLUNK_DB/defaultdb/thaweddb
          tstatsHomePath = volume:_splunk_summaries/defaultdb/datamodel_summary
          maxMemMB = 20
          maxConcurrentOptimizes = 6
          maxHotIdleSecs = 86400
          maxHotBuckets = 10
          maxDataSize = auto_high_volume
          [_internal]
          homePath   = $SPLUNK_DB/_internaldb/db
          coldPath   = $SPLUNK_DB/_internaldb/colddb
          thawedPath = $SPLUNK_DB/_internaldb/thaweddb
          tstatsHomePath = volume:_splunk_summaries/_internaldb/datamodel_summary
          maxDataSize = 1000
          maxHotSpanSecs = 432000
          frozenTimePeriodInSecs = 2592000

          [_audit]
          homePath   = $SPLUNK_DB/audit/db
          coldPath   = $SPLUNK_DB/audit/colddb
          thawedPath = $SPLUNK_DB/audit/thaweddb
          tstatsHomePath = volume:_splunk_summaries/audit/datamodel_summary

## Configuring Indexes
- indexes.conf manages all indexes
     - SPLUNK/etc/system/default
          - prebuilt indexes 
          - do not edit
     - Should be stored in
          - SPLUNK_HOME/etc/system/local
          OR
          - SPLUNK_HOME/etc/apps/<appname>/local
     - Structure (if duplicates last stanza wins)
          [main]
          homePath
          coldPath
          thawedPath
          tstatsHomePath 
          frozentimePeriodsInSecs (age)
          maxHotBuckets  
          maxDataSize    default 750mb 
          maxtotalDataSizeMB total max disk size or expires overrides frozen time period
          maxWarmDBCount number of warm buckets
## FishBucket
- special interal index checkpoint, keeps track of the ingestion process
- can tell where it might have left off
- SPLUNK/var/lib/splunk/fishbucket
- On restart splunk can pickup ingestion where it left off
- can re-index files
     - btprobe command
     - ./splunk cmd btprobe -d 
- delete the fishbucket and reindex data
     - rm -rf /opt/splunk/var/lib/splunk/fishbucket
## Data retention
- maxTotalDataSizeMB = default 500GB
- frozentimePeriodsInSecs = 6 years
- how to thaw
     - copy the archived bucket to thaweddb
     - ./splunk rebuild SPLUNK_HOME/var/lib/splunk/<index name>/thaweddb/<bucket name>
## Manage Index
- BACKUP
     - backup warm and cold
     - backup all the etc dir
     - hot cannot be backedup
     - clustered has replication
- Delete
     - index = * | delete 
     - virtual delete only (marked as deleted)
     - must have can_delete capablility in the user
- Cleaning out an index
     - not in prod or qa
     - destroyes data from dix
     - splunk clean all -index <index name>

## DEMO
default/indexes.conf
- global settings at the top
- check with the btool command 
     /opt/splunk/bin
     ./splunk btool indexes list <name> --debut | grep frozen 
          (you can add grep to the end of this command)
## reset fishbucket to reset files
