#
# Cookbook Name:: memcached-configuration
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

script "add /usr/local/lib to /etc/ld.so.conf.d/libevent.conf and Configure Dynamic Linker Run Time Bindings" do
  interpreter "bash"
  user "root"
  code <<-BASH
  echo '/usr/local/lib' > /etc/ld.so.conf.d/libevent.conf
  /sbin/ldconfig
  BASH
  not_if "test -f /etc/ld.so.conf.d/libevent.conf"
end

bin = node['memcached-configuration'][:bin]
con = node['memcached-configuration'][:con]
threads= node['memcached-configuration'][:threads]
mem = node['memcached-configuration'][:mem]

deploy = (data_bag_item 'users', 'deploy')['id']

template "/etc/init.d/memcached" do
  source "memcached.erb"
  
  owner 'root'
  group 'root'
  variables(:user => deploy, :con => con, :threads => threads, :mem => mem)
  mode 0775
  not_if "test -f /etc/init.d/memcached"
end

service 'memcached' do
  action [:enable, :start]
end
