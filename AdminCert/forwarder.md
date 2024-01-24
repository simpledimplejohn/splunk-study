# Splunk forwarder
- UF
    - source host
    - stripped down version of splunk
    - high performance, low footprint
    - does not do any parsing
        - structured data (json, csv) can be
    - 256 KBps 
        - limits.conf can increase
    - built-in lisence 
- HF
    - sits between UF and indexers INTERMEDIARY
    - parases before sending to the 
    - props.conf
    - transforms.conf
    - indexing can be turned on (not a common thing)
    - forwarder liencese (for indexing needs enterprise stack)
    - USED
        - parse special data
        - pre-treat data
        - mask security sensitive data
            - expensive so offload
    - FIREWALL rules (not for all the indexers)
        - only needs one server for the firewall
    - HOST addons 
        - HTTP event collector
        - DBConnect from databases
- Light Forwarder   
    - depricated

## INSTALL AND RUN
- linux
- windows
- max
- solaris
- AIX
- Free BSD
- inside docker 
### Steps
LINUX
- download the tar ball
- seperate file system 
    - /opt/splunkforwarder
- SPLUNK_HOME/bin ./splunk stop start
- default admin password <changeme>
    - a few admin commands exist
- ansible or puppet
    - help manage lots of them
WINDOWS
- MSI install wizard msiexec.exe command line
- admin privialges not needed if domain user
- msiexec.exe /quiite and AGREETOLICENSE =yes
    - silent install
- windows eventlogs perfomon ingestion
- Runs as a Windows service

## CONFIGURING STEPS
1. Setup recieving on the indexer
    - inputs.conf
        - add the listener paths
    - GUI settings/forwarding/receiving/configure receiving
    - CLI 
        - `splunk enable listen <port>` (default 9997) (non SSL port)
        - `netstat -an | grep 9997` (to vefify)
2. Add outputs to the forwarder (where to hit) (should be done with ansible)
    - outputs.conf
        [tcpout]
        defaultGroup = default-autolb-group
        [tcpout:default-autolb-group]
        server = 192.168.0.11:9997 
        [tcpout=server://192.168.0.11:9997]

    - `./splunk add forward-server <Reciever ip/host:port`
        -`./splunk add forward-server 192.168.0.11:9997`
    - `./splunk list forward-server` (lists active forwards)
3. Add Inputs to UF (done manually)
    - deployment server distributes inputs.conf
    - CLI
        `Ssplunk add monitor <path>` read the full file first, then tail each aditional time
        result is:
        [monitor:///User/john/Library/Logs/fsck_hfs.log]
        disabled = false
        - can verify with btool
            `btool inputs `
    - Edit inputs.conf location 
        [monitor:///User/John/Library/logs] file or directory
        host = john-mac.local
        index = default (indexer must exist first or it will fail)
        sourcetype = mac:system:fsck_log (application name, subsystem name, log file)
        _TCP_ROUTING = default-autolbgroup (if not specified the outputs.conf is used)
        blacklist = *trace.log (ignores files that match regex)

    - location precedence for UF (indexer style)
        - etc/system/local
        - etc/apps/search/local
        - etc/apps/<appname>/local
        - etc/apps/search/default
        - etc/apps/<appname>/default
        - etc/system/default
4. additional confs
    - forward selectivly to multiple indexers
        - define two tcpout destinations in putputs.conf
        - user _TCP_ROUTING in inputs.conf
    - load balance forwarding (used for lots of indexers)
        - server list in the output.conf
        - random switching every 30 seconds
    - compression
    - ssl 
        - can increase CPU usage 10-15%
        - compression
    - buffering queuing
        - indexers may not always be available
        - max queue size by default is 500kb
        - auto inc to 7MB
    - acknolegement 
        - protects against data loss
        - will resend the data if its not sent
        - ssl is better
        - wait queue is 3x size max queue size
        - useACK = true ouptuts.conf
    
## TROUBLESHOOTING FORWARDERS
- index=_internal host-<host> check to see if data is being sent
- on forwarder:
    `splunk status` command
    `splunk list forward-server` to check the desitination
- on indexer
    - `splunk display listen` shows all the listeners
- splunkd log
    - var/log/splunk/splunkd.log

## DEMO
1. downlaod and install
2. new password
3. `./splunk start --accept-license` (automatically accepts the liences and agrees to terems and conditions)

4. setting up forwarding
ON Splunk
`./splunk display listen` see if there is listening
`./splunk enable listen 9997` starts listening for forwarders
`./splunk btool inputs list` read the current inputs.conf file 
    [splunktcp://9997]
    _rcvbuf = 1572864
    connection_host = ip
    host = $decideOnStartup
    index = default
` ./splunk btool inputs list splunktcp://9997 --debug`
    /Applications/splunk/etc/apps/search/local/inputs.conf 
    shows that its in this file path inputs.conf file
ON UF
`./splunk list forward-server` list of active forwarders 
check ip address locally `ipconfig getifaddr en0`
`./splunk add forward-server 192.168.0.228:997` this adds forwarding to 9997