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

{
  'root' => '/root',
  'deploy' => '/home/deploy'
}.each do |user, path|
  git "rbenv" do
    repository "git://github.com/sstephenson/rbenv.git"
    reference "master"
    destination "#{path}/.rbenv"
    user user
    group user
    action :sync
  end

  #echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  directory "#{path}/.rbenv/plugins" do
    owner user
    group user
    recursive true
  end

  git "ruby-build" do
    repository "git://github.com/sstephenson/ruby-build.git"
    reference "master"
    user user
    group user
    destination "#{path}/.rbenv/plugins/ruby-build"
    action :sync
  end
  
end