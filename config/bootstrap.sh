#! /usr/bin/env bash

# Install basics
apt-get update
apt-get install git-core libncurses5-dev ruby ruby-dev rdoc libruby-extras  -y  

# Install Rubygems
cd /tmp
wget http://rubyforge.org/frs/download.php/69365/rubygems-1.3.6.tgz
tar xvf rubygems-1.3.6.tgz
cd rubygems-1.3.6
ruby setup.rb
cp /usr/bin/gem1.8 /usr/bin/gem
cd

# Install chef gems
gem install ohai chef github right_aws --no-rdoc --no-ri

# Set up local chef workspace
mkdir -p /var/chef-solo
cd /var/chef-solo
tar xzf /tmp/chef-solo.tgz

# Run chef
chef-solo -c /home/ubuntu/solo.rb -j /home/ubuntu/dna.json
