# General Notes

Componets
- Indexers 
    - recieves parses stores data ddemon
    - search head, 
        - GUI
        - dispatches searches to the indexes
    - UF collects data
    - License Master
        - manages the liceses (co-location possible)
    - Deplyment sercver
        - manages conf files on deplyment clients (UF, but anything)
            - serverclass.conf
        - could use Ansible....
        - uses apps which are conf files
        - nodes pull from this
    - cluster master
        - manages indexers (only one)
        - (can have a passive standby)
        - data bucket status 
        - replication
        - distrubtes conf files to the indexer clusert
    - search head deployer
        - has to be on its own server
    - monitoring console
        - DMC
    - HF
        - forwards data 
        - parses data
        - full splunk but no distrubuted search
        - can index data locally if needed

Systems admin
- install splunk
- indexes
- licenses
- securtiy

Data Admin
- inputs
- parsing
- pipelines
- config files