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
        - FIRST (at this time ifconfig is not showing the pi)
            - `ifconfig`
            - look for en0: 192.168.0.228 (personal machine)
        - THIRD
            - ping raspberrypi.local 192.168.0.105
            - control C
        - SECOND
            - `ssh pi@raspberrypi.local`
            - type yes
            - enter password

## Troubleshooting From The Pi
    - 

## Running as a server
How to run port-back-end from the pi
- `git clone https://github.com/simpledimplejohn/port-back-end.git`                
- Install node
    - `sudo apt-get update` (update os)
    - `sudo apt-get install -y nodejs npm` (install node and npm)
    - `node --version` `npm --version`
- Install dependencies
    - cd /port-back-end (where package.json is)
    - `npm install`
- start server `npm start` (if its in the package.json)
- OR `node server.js`

## Hit the endpoint with postman
- `http://192.168.0.105:3000/log`

## Install the Splunk Universal Forwarder
- 
