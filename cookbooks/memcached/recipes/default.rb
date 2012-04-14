#
# Cookbook Name:: memcached
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
src_dir = node[:memcached][:src_dir]
base = node[:memcached][:base]
tarball = node[:memcached][:tarball]
tarball_url = node[:memcached][:tarball_url]
tarball_checksum = node[:memcached][:tarball_checksum]

package "libevent-devel"

remote_file "#{src_dir}/#{tarball}" do
  source tarball_url
  mode "0644"
  checksum tarball_checksum
  action :create_if_missing
end

execute "tar" do
  cwd src_dir
  command "tar zxf #{src_dir}/#{tarball}"
  creates src_dir + "/" + base
  action :run
end

script "install memcached source code" do
  interpreter "bash"
  user "root"
  cwd src_dir + "/" + base
  code <<-BASH
  ./configure
  make
  make install
  BASH
  not_if { !!system('which memcached')}
end
