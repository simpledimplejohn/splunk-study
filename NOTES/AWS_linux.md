# AWS Linux
Using linux machines on aws.

## Spin Up An EC2
- Login to AWS and create EC2 in dashboard
    - key pair (an ssh key for logging in)
        - use pem for ssh
        - store in `~/.ssh`
            (which is `Users/johnblalock/.ssh`)
        - key will download use:
            `mv ~/Downloads/port-back-end.pem ~/.ssh/` to move the key
        - set the permissions for your ssh key locally
            `chmod 400 ~/.ssh/your-key-name.pem`
    - launch-wizard-1 is the auto generated security group
    - choose t2.micro free tier 8 GiB
- ssh into the ec2
    - `ssh -i ~/.ssh/blockjason.pem ubuntu@54.85.47.xxx`
    - clone the git repo
        `git clone https://github.com/simpledimplejohn/port-back-end.git` 
    - install nvm
        `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash`
        run this as well
        `source ~/.bashrc`
    - install node
        `nvm install node`
    - check they are installed
        `npm -v`
        `node -v`
    - install dependencies
        `npm install`
    - start the server
        `node server` 
    - Read logs in realtime
        `sudo tail -f app_logs.log`

## Install splunk on an Ubuntu instance
- Generate EC2 instance and ssh into it
- Set up a security group for managing the port access
- Install Splunk
wget -O splunk-9.2.0.1-d8ae995bf219-Linux-x86_64.tgz "https://download.splunk.com/products/splunk/releases/9.2.0.1/linux/splunk-9.2.0.1-d8ae995bf219-Linux-x86_64.tgz"
- extract the tgz file with
`tar xvzf splunk-9.2.0.1-d8ae995bf219-Linux-x86_64.tgz`
- start splunk with 
`./bin/splunk start`
- set up security groups for these ports
	Checking http port [8000]: open
	Checking mgmt port [8089]: open
	Checking appserver port [127.0.0.1:8065]: open
	Checking kvstore port [8191]: open
    - 8000 and 8089 accessable
- go to the address provided when you run the start command
## troubleshooting splunk
- unable to access the gui
    - use a telnet command 
    - `brew install telnet`
    - `http://3.91.208.198:8000` to access splunk 

## Install Splunk UF
wget -O splunkforwarder-9.2.0-1fff88043d5f-Linux-x86_64.tgz "https://download.splunk.com/products/universalforwarder/releases/9.2.0/linux/splunkforwarder-9.2.0-1fff88043d5f-Linux-x86_64.tgz"
- Setting up forwarding
    - `tar xvzf splunkforwarder.....tgz`
    - start the forwarder
        `~/bin/splunk start`
    - create the folder local in `etc/apps/search/local`
    - create the inputs.conf file in `etc/apps/search/local/inputs.conf` and add the stanza
        [monitor:///home/ubunutu/port-back-end/log/app_logs.log] 
        sourcetype: app_logs
        index: port-back-end
    - In the Splunk instance
        - create the index port-back-end on the GUI
        - add listening to port 9997
    - In the forwarder
        - add the inputs.conf with the command
            `./splunk add forward-server 54.85.47.216:9997`

## Cloudwatch
- Metrics in cloudwatch
- store in paramater

