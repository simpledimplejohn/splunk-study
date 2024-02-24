# Raspberry Pi Server
Running software on a raspberry pi.

## Settup
Operating System
- Raspberry Pi Imager app on mac
    - Load micro sd card
    - lauch imager
    - Choose Operating system
        - Ubuntu Server 23.10 (64-bit)
    - Apply custom settings (this can be done with manual config files in the os)
        - set username and password
        - Configure wireless lan (connect to local internet)
- Accessing the Pi remotelly
    - Find the ip address
        - FIRST
            - `ifconfig`
            - look for en0: 192.168.0.228 (personal machine)
        - SECOND
            - `ssh pi@raspberrypi.local`
            - type yes
            - enter password

                


