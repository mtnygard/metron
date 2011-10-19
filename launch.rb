#! /usr/bin/env ruby -rubygems

require 'yaml'
require 'fog'
require 'net/sftp'
require 'net/ssh'

puts "Bundling cookbooks"
system("tar czf tmp/chef-solo.tgz roles cookbooks")

# TODO: read a config file to find the locations of these secrets
# TODO: some notion of environments and/or clients
ssh_key_file="config/identity.pem"
ec2_key_name=IO.read("config/key_name").chomp
ec2_machine_type="m1.large"
ec2_image_id="ami-fd589594"
ec2_security_group="metron-security-group"
ec2_machine_tag="Metron: Metrics and Monitoring server"

aws_credentials = {
  :aws_access_key_id => IO.read("config/access_key").chomp,
  :aws_secret_access_key => IO.read("config/secret_key").chomp
}

# TODO: Create security group if it doesn't already exist.

@connection = Fog::Compute.new(aws_credentials.merge(:provider => 'AWS'))

puts "Launching server"

server = @connection.servers.create(
                                    :image_id => ec2_image_id,
                                    :flavor_id => ec2_machine_type,
                                    :groups => ec2_security_group,
                                    :key_name => ec2_key_name
                                    )

@connection.tags.create(:key => 'Name',
                        :value => ec2_machine_tag,
                        :resource_id => server.id)

puts "Waiting for #{server.id} to boot"

server.wait_for { ready? }

puts "Waiting for a decent interval to let sshd get started."
sleep 30

def upload(session, local, remote)
  puts "Uploading #{local} -> #{remote}"
  session.sftp.upload!(local, remote)
end

Net::SSH.start( server.dns_name, 'ubuntu', :keys => [ ssh_key_file ], :paranoid => false ) do |ssh|
  puts "Uploading payload files"
  
  upload(ssh, "tmp/chef-solo.tgz", "/tmp/chef-solo.tgz")
  upload(ssh, "config/solo.rb", "/home/ubuntu/solo.rb")
  upload(ssh, "config/dna.json", "/home/ubuntu/dna.json")
  upload(ssh, "config/bootstrap.sh", "/home/ubuntu/bootstrap.sh")

  puts "Running bootstrap"
  
  ssh.exec!("sudo sh ./bootstrap.sh") do |channel, stream, data|
    puts data
  end
end

puts "You should be able to reach your server at http://#{server.dns_name}/"
