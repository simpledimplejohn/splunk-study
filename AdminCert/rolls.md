# User Rolls

## Security methods
    User => HTTPS => Search Heads 
    Search heads => LDAP(S) => enterrpise security SSO
    clustermembers => pass4symmkey => cluster members
    UF => SSL/TLS => indexers
    Searchhead => SSL/TLS => indexer

## Splunk Roles 
- Capabilities
    - search
    - scheduled_search
    - edit_sourcetypes
    - rtsearch (realtime searches)
    - license_edit 
    - admin_all_objects (modify any object in the system)
- Edit roles
    - web
    - configuration files
        - authorize.conf
- Builtin Roles
    - admin
        - mondify all objects
    - power
        - create and edit shared objects
    - user
        - create and edit own objects
    - can_delete
        - delete events by keyword
        - admin does not have this
        - data not removed but not visable
    - splunk-system-role
    # Btool
        ./splunk btool authorize list <role_power>
## create a user
    - web 
## audit
    - index=_audit user=test "login attempt"
    - index=_audit user=test | transaction startswith="login attempt" endswith="logout" | table duration 

## CUSTOME ROLES 
- why?
    - index security, limit who can access
        - srchIndexesAllowed
    - knowledge object security
    - default roles changed on updates
- restrictions
    - Default App
    - search job limit
        - number of searches a user with this rolse can run at the same time
    - role search job limit
        - default unlimited
    - disk space limit
        - disk job limit (default 100MB)
- using configuration files
    - authentication.conf
        - LDAP settings and map LDAP roles
    - user-prefs.conf
        - default app
        /etc/app/user-prefs/local/usedr-prefs.conf
    - authorize.conf
        - Splunk/etc/system/default/authorize.conf
        - create /etc/system/local/authorize.conf
            or   /etc/apps/auth_app/local/authorize.conf (prefered)
        - inclustered enviroment place these in the search head not indexers
        - creates roles
        # authorize.conf
        [role_test_role]
        importRoles = user (the role that gets inherited)
        srchIndexesAllowed = main
        srchIndexesDefault = main
        srchJobsQuota = 20 (default is 3)

## Inheritance
roles can be based on existing roles
- inherited capabilities cannot be removed
## Add user with custom role
- LDAP user
    - map LDAP group in authentication.conf
    - any user in LDAP group gets the role
    authentication.conf
    [authentication]
    authType = LDAP
    authSettings = myLDAP

## disk usage
| rest services/admin/quota-usage | search user=blalockj
    shows diskUsage in kb