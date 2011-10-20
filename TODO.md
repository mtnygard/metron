# TODO

## Major items

1. Pick a monitoring server and add it to cookbooks.
1. Allow clients to announce themselves to the server.
1. Write a client-side cookbook for use in chef-solo (take an IP addr
or DNS name for loc'n of server). Install statsd.
1. Make a default config for Ruby on Rails apps. Automate in a cookbook.

## Minor items

1. Externalize configuration, take a command-line arg for which config file
1. Create a status check script
1. (Maybe) Use Thor to do command / subcommand structure
1. Introduce idea of environment (to support multiple clients)
1. If Elastic IP provided in config, claim it on startup
1. Create a shutdown script (low priority... knife, ec2-api-tools, and
web console all allow same)
