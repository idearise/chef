#
# Cookbook Name:: redisio 
# Resource::uninstall
#
# Copyright 2012, Brian Bianco <brian.bianco@gmail.com> 
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

actions :run, :nothing

attribute :servers, :kind_of => Array, :default => nil

def initialize(name, run_context=nil)
  super
  @action = :nothing
end

