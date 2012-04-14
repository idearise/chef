#
# Cookbook Name:: users-configuration
# Recipe:: default
#
# Copyright 2012, Stephen Paul Suarez
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#



gem_package "ruby-shadow"
#require_recipe "mysql"
item = data_bag_item 'users', 'deploy'

# for each admin in the data bag, make a user resource
# to ensure they exist
group item['id'] do
  gid item['gid']
end

user item['id'] do
  uid item['uid']
  gid item['gid']
  shell item['shell']
  comment item['comment']
  password item['password']
  home ('/home/%s' % item['id'])
  supports :manage_home => true
  action :create
end
# Create an "admins" group on the system
# You might use this group in the /etc/sudoers file
# to provide sudo access to the admins

group "admins" do
  gid 999
  members [item['id']]
end

directory "/home/#{item['id']}/.ssh"

template "/home/#{item['id']}/.ssh/authorized_keys" do
  source "authorized_keys.erb"
  action :create
  owner item['id']
  group item['id']
  variables(:keys => item['authorized_keys'])
  mode 0440
  #not_if { defined?(node[:users][name][:preserve_keys]) ? node[:users][name][:preserve_keys] : false }
end

package "sudo" do
  action :upgrade
end

template "/etc/sudoers" do
  source "sudoers.erb"
  action :create
  owner 'root'
  group 'root'
  variables(:sudoers => [item])
  mode 0440
  #not_if { defined?(node[:users][name][:preserve_keys]) ? node[:users][name][:preserve_keys] : false }
end

mysql_bin = '/usr/local/mysql/bin'#[node[:mysql][:target], 'bin'].join('/')
paths = {}
if File.exist?(mysql_bin)
  paths.update({:mysql => mysql_bin})
end

template "/root/.bash_profile" do
  source "bash_profile.erb"
  action :create
  owner 'root'
  group 'root'
  variables(:paths => paths)
  mode 0770
  #we probably always want to regenerate this everytime chef-client runs ?
  #only_if "test -d #{mysql_bin}"
end

template "/home/#{item['id']}/.bash_profile" do
  source "bash_profile.erb"
  action :create
  owner item.id
  group item.id
  variables(:paths => paths)
  mode 0770
  #we probably always want to regenerate this everytime chef-client runs ?
  #only_if "test -d #{mysql_bin}"
end

template "/home/#{item['id']}/.gemrc" do
  source "gemrc.erb"
  action :create
  owner item.id
  group item.id
  variables(:paths => paths)
  mode 0770
  #we probably always want to regenerate this everytime chef-client runs ?
  #not_if "test -f /home/#{item['id']}/.gemrc"
end

template "/root/.gemrc" do
  source "gemrc.erb"
  action :create
  owner "root"
  group "root"
  variables(:paths => paths)
  mode 0770
  #we probably always want to regenerate this everytime chef-client runs ?
  #not_if "test -f /root/.gemrc"
end

=begin
cookbook_file "/etc/ssh/sshd_config" do
  source "sshd_config"
  mode "700"
  not_if "test -f /etc/chef/env/sshd_config_secured"
end

service "sshd" do
  action :restart
  not_if "test -f /etc/chef/env/sshd_config_secured"
end

execute "flag the restart of ssh after sshd_config reconfiguration" do
  cwd '/etc/chef/env'
  command "touch sshd_config_secured"
  creates "/etc/chef/env/sshd_config_secured"
  action :run
end
=end