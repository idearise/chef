#
# Cookbook Name:: postgresql
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
package "postgresql"
package 'postgresql-server'
package "postgresql-devel"

#service postgresql initdb
script "initialize postgres" do
  interpreter "bash"
  user 'root'
  code <<-BASH
  service postgresql initdb
  touch /etc/chef/env/initialized_postgresql
  BASH
  not_if "test -f /etc/chef/env/initialized_postgresql"
end

service "postgresql" do
  action [:enable, :start]
end

#we'll probably put postgres configuration here instead

cookbook_file "/var/lib/pgsql/data/pg_hba.conf" do
  source "pg_hba.conf" # this is the value that would be inferred from the path parameter
  mode "0644"
end