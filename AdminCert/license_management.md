
Licensing Options
based on amount of ingested data
- Enterprise
    - most common
    - all features
    - no-enforcement (can search indexed data even with violations)
- Free
    - 500MB/day
    - limited
        - clustering
        - authentication
        - distrubited
- Trial
    - 60 days
    - 500 mb/day
    - becomes free
    - sales Trial (customized)
- Industrial IoT
    - IoT only 
    - cannot be stacked
- Forwarder License
    - cannot be used for indexing
    - automatically applyied
    - HF okay if not indexing
- Dev/Test license for apps
    - non-prod
    - not distrubuted
    - not stacked

- Daily license quoto
    - full size of data flowing through parsing queue
    - not final disk storage (compressed)
    - not replicated data
    - not summary indexes
    - not internal logs
    - not metadata

- Distrubuted license
    - master has the license 

- License Violation
    - Wranings
        - exceed daily quota 
        - 5x in 30 days = violation
    - search not disabled
    - alert logged in messages (in all enviorments)
    - monitor
        - license monotioring alerts in DMC
        - splunk web license page
        - usage report in splunk web
    - resets at midnight
    - buy more license

