# Authentication Mechanisms
Settings/Users And Authentications/Authentication Methods
- How users are authenticated 
    - Native (always on) (comes with)
    - External LDAP (most common)
    - SAML (what we used) security assertion markup language XML
    - scripted authentication (custom built)
- NATIVE
    - cannot be disabled
    - added edited and deleted from web
    - SPLUNK/etc/passwd   (where users are stored)
        :blalockj:$6$XTsuQ/MlR796oeAG$.GNcFRjhexmK2nsohs.cWJE7Thw5Lc0mividF9ZxNT/C9XvJMwg37k15BJLWOT7HPisoyy6m8INWkjqFF96U8.::Administrator:admin:changeme@example.com:::19705
        :test:$6$hhka0JCejYVW8Pc7$9oQIXlhYwNtAZGzo5Gt5ePnIE.Kfrye9RZjst3A.RwtcFNvPLwSzSnFKXGcB1lFWF5wSLbIlskuwdcUEaw9NO1::test:power;user:test@test.com:::19741
- LDAP
    - Strategy (means configuration)
        - LDAP host and port number
        - From LDAP admin
            - Bind credentials
            - User based DN and group based DN
            - user-name attributes 
            - real-user-name attributes
            - Group-name attributes 
            - static-member attributes
    - SPLUNK CLIENT <=> Sedarchhead <=> External LDAP server
        - creates a user session 
        - gets group membership so role can be captured
    - Maping LDAP to roles
        - We do this as admin
            - Splunk Web
            - authentication.conf
                [authentication]
                authType = LDAP
                authSettings = myLDAP
                [roleMap_mayLDAP]
                sales_user = sales (splunk role to group in LDAP server)
            - authorization.conf
                [role_sales_user]
                importRoless = user
    - DEMO free LDAP test server
        - https://www.forumsys.com/tutorials/integration-how-to/ldap/online-ldap-test-server
        - ldap.forumsys.com
        - 389
        - Bind DN cn-read-only-admin,dc=example,dc=com
        - Bind DN Password (make this)
        - User Settings
            - User Based DN dc=example,dc=com
        - Group settings
            - Group based DN dc=example,dc=com
            - OU
            - Unique member
        - MUST BE MAPPED TO ROLE
            - pick group 
                - map group to role
        - USER
            uid=euler,dc=example,dc=com
        
- SSO
    - SPLUNK CLIENT <=> Searchhead <=> Identity Provider (ping/Azure) 
        - sends an XML doc back to the search head
        - creates session
        - gets group membership to map to role
    - Setup
        - Need a provider (ping identity)
        - Role realname, mail attributes
        - identity provider metadata file (get from them)
        - SSL certificate info
        - Map SAML groups to Splunk roles
- MFA
    - Suported
        - DUO Security
        - RSA Security
    - Configure
        - Secret Key come from the setup
        - API host name 
        - 