require 'json'

root = File.dirname(__FILE__) + "/.."
machines_info = JSON.parse(File.read(root + '/data_bags/machines/list.json'))

machine_info = machines_info[machines_info['alias']['dev_env']]
dev_env = machine_info['fqdn']


namespace :linode do
  desc "login to #{dev_env}"
  task :login do
    system("ssh root@#{dev_env}")
  end
  
  desc "assign role" 
  task :assign_role do
    system(%(knife node run_list add #{dev_env} "role[dev_env]"))
  end
  
end