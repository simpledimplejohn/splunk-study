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
    - `ssh -i ~/.ssh/blockjason.pem ubuntu@54.85.47.216`
    - clone the git repo
        `git clone https://github.com/simpledimplejohn/port-back-end.git` 
    - install nvm
        `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash`
    - install node
        `nvm install node`
    - check they are installed
        `npm -v`
        `node -v`
    - install dependencies
        `npm install`
    - start the server
        `node server` 