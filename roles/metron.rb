name "metron"
description "Metrics collection station."

run_list  "recipe[apache2]", "recipe[graphite]"

# TODO: figure out how to pass these in from files.
override_attributes "aws" => {
  "access_key" => "",
  "secret_key" => "",
  "ip" => ""
}
