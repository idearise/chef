require 'json'

root = File.dirname(__FILE__) + "/.."
machines_info = JSON.parse(File.read(root + '/data_bags/machines/list.json'))

machine_info = machines_info[machines_info['alias']['dev_env']]
dev_env = machine_info['fqdn']

assign_role = %(knife node run_list add #{dev_env} "role[dev_env]")

namespace :linode do
  task :fqdn do
    puts dev_env
  end
  
  desc "login to #{dev_env}"
  task :login do
    user = ENV['user'] || 'deploy'
    system("ssh #{user}@#{dev_env}")
  end
  
  task :assign_role do
    system(assign_role)
  end
  
  task :chef_client do
    system("cap chef:client")
  end
  
  namespace :upload do
    task :keys do
      #upload keys for each user!
      %w[id_rsa id_rsa.pub].each do |f|
        if File.exist?(root + '/' + f)
          system("scp #{root}/#{f} root@#{dev_env}:/root/.ssh/" + f)
          system("scp #{root}/#{f} deploy@#{dev_env}:/home/deploy/.ssh/" + f)
        end
      end

    end
  end
  
end
namespace :upload do
  task :cookbook do
    cookbook = ENV['COOKBOOK'] || '-a'
    system('knife cookbook upload ' + cookbook)
  end
  
  task :role do
    role = ENV['ROLE'] || '*'
    system('knife role from file roles/' + role + '.rb')
  end
  
  task :data_bag do
    #create the databag(even if it's already created and then upload the file)
    Dir[File.join(root, 'data_bags') + '/*'].each do |potential_bag|
      next unless File.directory?(potential_bag)
      bag = File.basename(potential_bag)
      system('knife data bag create ' + bag) rescue nil
      Dir[File.join(root, 'data_bags') + '/' + bag + '/*.json'].each do |item|
        system('knife data bag from file ' + bag + " #{File.basename(item)}")
      end
    end
  end
  
  task :all => [:role, :cookbook, :data_bag, 'linode:upload:keys']
  
end

task :upload => ['upload:all']

desc "the task to call after doing the bootstrap"
task :setup_after_bootstrap => ['upload', 'linode:assign_role', 'linode:chef_client']