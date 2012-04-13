current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "devpopol"
client_key               "#{current_dir}/devpopol.pem"
validation_client_name   "precise-validator"
validation_key           "#{current_dir}/precise-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/precise"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
