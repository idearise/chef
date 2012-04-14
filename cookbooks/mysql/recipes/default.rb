#
# Cookbook Name:: mysql
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
src_dir = node[:mysql][:src_dir]
base = node[:mysql][:base]
tarball = node[:mysql][:tarball]
tarball_url = node[:mysql][:tarball_url]
tarball_checksum = node[:mysql][:tarball_checksum]
target = node[:mysql][:target]

package 'cmake'

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

script "install mysql cluster source code" do
  interpreter "bash"
  user "root"
  cwd src_dir + "/" + base
  code <<-BASH
  sudo sh BUILD/autorun.sh
  ./configure
  make
  make install
  BASH
  not_if { File.exist?(target)}
end
