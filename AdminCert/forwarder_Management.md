# Managing Many Forwarders
use a central server to distrubute apps
## Things to manage
things to manage
- Adding indexes needs to be updated in the outputs.conf
- changes to the inputs inputs.conf
- if forwarder is down, need to be alerted 
    - fishbucket shows when restart 
    - if source logfile gets archived this can get messed up
- cannot install or upgrage forwarders
    - ansible needed

## Splunks Deployment Server
- need an enterprise license 
- splunk web can access
- dedicated deployment server
    - not resource heavy like an indexer
- centrally stores configuration file
    - central app called deployment apps
        - outputs.conf
        - inputs.conf
## Deployment apps
The object that makes distrubtion possible
- SPOUNK_HOME/etc/deployment-apps (on the deployment server)
- SPLUNK_HOME/etc/apps (on the forwarder)
sample_app
    appserver
        static
            application.css
    default
        app.conf (required)
        indexes.conf
        inputs.conf
        props.conf
    local (precidence)
        app.conf (required)
        indexes.conf
        inputs.conf
        props.conf
    logs
        maillog
    metadata
        default.meta (required)
        local.meta (overrides)

## Created 
- add an app in the directory

## Configure deployment clients
done on the forwarder first 
- deploymentclient.conf
command to do this
`./splunk set deploy-poll 192.168.0.11:8089`
deploymentclient.conf 
[target-broker:deploymentServer]
targetUri =  192.168.0.11:8089  (how to connect)

clientName = myWebServer        (custom name of the forwarder otherwise its host name)
phoneHomeIntervalInSecs = 120   (how often it phones home)

## ServerClass
connects deployment client to deployment server
groups hosts and designates deployment apps to be deployed
- serverclass.conf
[serverClass:acme-forwarders:app:acme-forwarder-limits]
restartSplunk
[serverClass:came-forwars]
whitelist.0 = uf1


## Monitoring Forwarders
- monitoring console can enable this
- every 15 mins a lookup table is built
    - dmc_forwarder_assets
    - rebuilt this table 
        - do during off peak hours
        - settings/forwarder monitoring setup/ rebuild forwarder assets
- Forwarder state (active or missing)
- data throughput
- event throughput

## DEMO
settings/forwarder managment (shows apps added)
SPLUNK_HOME/etc/deployment-apps/test-app/ (add all the apps here)

NOW CONFIGURE A CLIENT
    ON THE UF
    `./splunk set deploy-poll 192.168.0.11:8089`
    CREATES deploymentclient.conf
    [target-broker:deploynetServer]
    targetUri = 192.168.0.11:8089
this should show up in the fowrwrader managment
in the GUI you can add the serverclass
