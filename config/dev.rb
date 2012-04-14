require 'json'

root = File.dirname(__FILE__) + "/.."
machines_info = JSON.parse(File.read(root + '/data_bags/machines/list.json'))

machine_info = machines_info[machines_info['alias']['dev_env']]
dev_env = machine_info['fqdn']

assign_role = %(knife node run_list add #{dev_env} "role[dev_env]")
bootstrap = %(knife bootstrap #{dev_env} -d centos6)

namespace :linode do
  desc "login to #{dev_env}"
  task :login do
    system("ssh root@#{dev_env}")
  end
  
  task :bootstrap do
    puts bootstrap
  end
  
  task :setup do
    puts [bootsrap, assign_role].join(" && ")
  end
  
  
  desc "assign role" 
  task :assign_role do
    system(assign_role)
  end
  
end