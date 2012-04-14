#
# Cookbook Name:: rbenv
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

git "rbenv" do
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  destination '/home/deploy/.rbenv'
  user "deploy"
  group 'deploy'
  action :sync
end

#echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
directory "/home/deploy/.rbenv/plugins" do
  owner 'deploy'
  group 'deploy'
  recursive true
end

git "ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  user "deploy"
  group 'deploy'
  destination '/home/deploy/.rbenv/plugins/ruby-build'
  action :sync
end
