require 'etc'

require_recipe 'mysql'

root = node["mysql-configuration"].root_path
path_generator = ->(*args){ [root,*args].join("/")}
target = node.mysql.target

group 'mysql'
user 'mysql' do
  home path_generator.()
  group 'mysql'
  system true
  supports :manage_home => true
end

user 'mysql' do
  action :lock
end

#make the mysql the owner of target
execute "make mysql user the owner of #{target}" do
  command "chown -R mysql.mysql #{target}"
  action :run
  not_if {  Etc.getpwuid(File.stat(target).uid).name == 'mysql' and Etc.getgrgid(File.stat(target).uid).name == 'mysql' }
end


directory path_generator.() do
  action :create
  owner "mysql"
  group "mysql"
  recursive true
  not_if "test -d "+path_generator.()
end


directory path_generator.('.ssh') do
  action :create
  owner 'mysql'
  group 'mysql'
  not_if "test -d " + path_generator.('.ssh')
end

item = data_bag_item 'users', 'deploy'
template path_generator.('.ssh','authorized_keys') do
  source "authorized_keys.erb"
  action :create
  owner 'mysql'
  group 'mysql'
  variables(:keys => item['authorized_keys'])
  mode 0440
  not_if "test -f #{path_generator.('.ssh','authorized_keys')}"
end


template '/etc/init.d/mysql.server' do
  source "mysql.server.erb"
  
  owner 'root'
  group 'root'
  variables(:data_dir => path_generator.(), :base_dir => target)
  mode 0775
  not_if "test -f /etc/init.d/mysql.server"
end

template '/etc/my.cnf' do
  source "my.cnf.erb"
  
  owner 'mysql'
  group 'mysql'
  variables(:data_dir => path_generator.())
  mode 0775
  not_if "test -f /etc/chef/env/my_cnf_installed"
end

execute "flag the installation of my.cnf" do
  cwd '/etc/chef/env'
  command "touch my_cnf_installed"
  creates "/etc/chef/env/my_cnf_installed"
  action :run
end

execute "mysql_install_db" do
  cwd target
  user 'mysql'
  group 'mysql'
  #command "scripts/mysql_install_db --datadir=#{path_generator.()}" 
  command "bin/mysql_install_db --datadir=#{path_generator.()}" 
  creates path_generator.('mysql')
end

service "mysql.server" do
  action :enable
end