#
# Cookbook Name:: redis-configuration
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
template "/etc/init.d/redis-server" do
  source "redis-server.erb"
  owner 'root'
  group 'root'
  mode 0775
  
  action :create
  not_if "test -f /etc/init.d/redis-server"
end

template "/etc/redis.conf" do
  source "redis.conf.erb"
  owner 'root'
  group 'root'
  mode 0770
  
  action :create
  not_if "test -f /etc/redis.conf"
end

group 'redis'

user 'redis' do
  home '/var/lib/redis'
  group 'redis'
  system true
  supports :manage_home => true
end

user 'redis' do
  action :lock
end

directory "/var/log/redis" do
  owner 'redis'
  group 'redis'
  
  action :create
  not_if "test -d /var/log/redis"
end


service 'redis-server' do
  action :enable
end