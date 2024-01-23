# Splunk Setup

## Single Instance Mac

## UNISTALL 
1. Stop Splunk Enterprise.

$SPLUNK_HOME/bin/splunk stop 
2. Find and kill any lingering processes that contain "splunk" in its name.
for macos
kill -9 `ps ax | grep splunk | grep -v grep | awk '{print $1;}'`
3. Remove the Splunk Enterprise installation directory, $SPLUNK_HOME. For example:
Note: For Mac OS, you can also remove the installation directory by dragging the folder into the trash.
4. Delete the splunk user and group, if they exist.


## REINSTALL 
1. download and copy to applications
2. /bin/ ./splunk start
3. http://Johns-MBP.home:8000  
    for the gui (search head)

## UNIVERSAL FORWARDER
