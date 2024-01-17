# .conf files

## location
/opt/splunk/SPLUNK_HOME/etc/

Enterprise and Universal Forward

## Platform Directory Structure

/SPLUNK_HOME
/bin ~./splunk restart
/etc
    /apps (conf files)
    /users (user spec files)
        - user owned objects
    /system
        /README (has example files for everything)
    /var
        /log (splunkd logs)
        /lib (indexes live here)

## file setup
indexes.conf
[default]
key = value

## Layering
- Splunk App
    A directory etc/apps
    can contain scripts
    add-on's are apps 
    Search & Reporting (default app)
- SPLUNK_HOME/etc/apps/name  (file structure for apps)
    /bin scripts
    /default (shipped with splunk, never update)
        conf
    /local (changes will be preseved, added later)
        takes president over default
        conf
    /metadata (permissions)
        default.meta
        local.meta 
- ALL PLACES THAT CONF FILES EXIST
    - etc/system/default
    - etc/system/local
    - etc/apps/search/default
    - etc/apps/search/local
    - etc/apps/<app>/default
    - etc/apps/<app>/local
    - etc/user/<user>/<app>/local

## INDEX-TIME vs Search-time
- Index-time precedence
    1. /etc/system/local
    2. /etc/apps/search
    3. etc/apps/<app>/local
    4. etc/apps/search/default
    5. etc/apps/<app>/default
    6. etc/system/default
    - Conflicting settings, highest level overrides all
- Search-time Precidence
    1. etc/users/<user>/<app>/local
    2. etc/apps/<app>/local
    3. etc/apps/<app>/default
    4. etc/apps/search/local
    5. etc/apps/search/default
    6. etc/system/local
    7. etc/system/default
 merges files on startup
 local allways presidence over default
 union of all files 

Do not copy over the default options, just add the new option

## btool
splunk command 
SPLUNK_HOME/bin

splunk btool <finename> list [options]
./splunk btool 
cd ../etc/  
cd system/default
vi props.conf

## monitoring paths list command
- List of monitoring paths
    - johnblalock@Johns-MBP bin % ./splunk btool inputs list monitor
    - ./splunk btool inputs list monitor --debug

