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

## Install Splunk UF
wget -O splunkforwarder-9.2.0-1fff88043d5f-Linux-x86_64.tgz "https://download.splunk.com/products/universalforwarder/releases/9.2.0/linux/splunkforwarder-9.2.0-1fff88043d5f-Linux-x86_64.tgz"
- Run the setup for the UF

