# Metron = Metrics + Monitoring

Create and manage an EC2 instance for collecting metrics across dev
and QA environments.

# Setup

## Bootstrap your environment

    ./scripts/bootstrap

## Configure for EC2

You will need to drop 4 files into config. These files are in
`.gitignore` so they will not be checked in.

* `access_key` - AWS access key. Contents should be the access key, in text.
* `secret_key` - AWS secret key. Contents should be your secret access key, in text.
* `identity.pem` - Identity file used to log in. Contents will be an X.509 certificate.
* `key_name` - File containing the name of an AWS key to use. Should correspond to the identity file.

I suggest making symlinks to your primary source for each of these. For example,

    ln -s ~/.ec2/access_key.txt config/access_key
    ln -s ~/.ec2/secret_access_key.txt config/secret_key

And so on.

# Usage

## Commands

vagrant up --provider=aws
Bootstrap and configure a new instance on EC2.

vagrant up
Bootstrap and configure a virtual machine on your local box.

# GUI

The Graphite GUI will be available on port 80 after boot. When using a
local VM, the GUI will be at http://33.33.33.10/.
