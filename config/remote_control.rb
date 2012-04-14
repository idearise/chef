require 'json'

root = File.dirname(__FILE__) + "/.."
machines_info = JSON.parse(File.read(root + '/data_bags/machines/list.json'))

machine_info = machines_info[machines_info['alias']['dev_env']]
dev_env = machine_info['fqdn']

role :wholestack, dev_env
set :user, "root"

namespace :chef do
  task :client, :roles => [:wholestack] do
    run "chef-client"
  end
end
