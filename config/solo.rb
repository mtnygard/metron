# Describe the environment on the EC2 Instance
#
# Used by chef-solo when installing cookbooks

file_cache_path "/var/chef-solo"
cookbook_path "/var/chef-solo/cookbooks"
role_path "/var/chef-solo/roles"
