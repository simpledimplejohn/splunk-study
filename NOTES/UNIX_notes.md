# Unix Commands

ls -ltr 
    - l is long format
    - t sorts by modication order
    - r reverses so newest are at the bottom 
    This command makes the info more readily readable

cd ~/Desktop
    - make sure there is a space
    - ~ is the home directory
cd /  goes to the root directory
curl command
    - curl <option> <url>
        - options
            -H (headder)
            -k (insecure)
check ports
    - sudo netstat -tuln 

## vi editor
- i insert
- :wq  
    : command mode
    w save/write
    q quit the editor
- :q! quits without saving

## Network connections
- ifconfig 
    shows network settings
- ping raspberrypi.local   
    192.168.0.103
- ping google.com 
    PING google.com (142.251.33.110): 56 data bytes
- sudo nmap -sn 192.168.0.103
- ssh pi@192.168.0.103 

## Setting up the raspberry pi
- echo 'password' | openssl passwd -6 -stdin
    (this creates a hashed password connected to my machine)
    this is done with the sd card inserted
- diskutil eject /Volume/bootfs
## Search 
- find /bootfs -type d -name "ssh"
- find /bootfs -type f -name "ssh"

## Basics
- rm <filename>
- rm -r /path/to/directory
- cp source_file destination_file

## directories
- Log files
    /var/log applog.log
- configration files
    /etc
- commands
    /bin 