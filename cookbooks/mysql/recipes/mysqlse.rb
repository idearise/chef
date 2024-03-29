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
#the version that has Mysql Sphinx Engine 
package 'cmake'
package "patch"
package "bison"

sph_src_dir = node[:mysql][:sphinx][:src_dir]
sph_base = node[:mysql][:sphinx][:base]
sph_tarball = node[:mysql][:sphinx][:tarball]
sph_tarball_url = node[:mysql][:sphinx][:tarball_url]
sph_tarball_checksum = node[:mysql][:sphinx][:tarball_checksum]

remote_file "#{sph_src_dir}/#{sph_tarball}" do
  source sph_tarball_url
  mode "0644"
  checksum sph_tarball_checksum
  action :create_if_missing
end

execute "tar" do
  cwd sph_src_dir
  command "tar zxf #{sph_src_dir}/#{sph_tarball}"
  creates sph_src_dir + "/" + sph_base
  action :run
end

src_dir = node[:mysql][:src_dir]
base = node[:mysql][:base]
tarball = node[:mysql][:tarball]
tarball_url = node[:mysql][:tarball_url]
tarball_checksum = node[:mysql][:tarball_checksum]
target = node[:mysql][:target]

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

p = [src_dir, base, 'storage/sphinx'].join('/')

execute "cp msyqlse engine sources to msyql storage plugin directory" do
  #cp -R -p $SPHX/mysqlse $MYSQL/storage/sphinx
  command %(cp -R -p #{sph_src_dir + '/' + sph_base}/mysqlse #{p})
  not_if { Dir["#{p}/*"].size > 0 }
end

=begin
#apply the patch for 2.0.4 -- apparently, this is still a work in progress
#ref: http://sphinxsearch.com/forum/view.html?id=8982
#ref: http://sphinxsearch.com/bugs/view.php?id=1090
cookbook_file "#{p}/snippets_udf.cc.patch" do
  source "snippets_udf.cc.patch"
  mode "775"
  owner 'root'
  group 'root'
  not_if "test -f #{p}/snippets_udf.cc.patch"
end

script "execute snippets_udf patch" do
  interpreter "bash"
  user "root"
  cwd "/root"
  code <<-BASH
  patch -p1 < #{p}/snippets_udf.cc.patch #{p}/snippets_udf.cc
  touch /etc/chef/env/sphinx_snippets_udf_patched
  BASH
  not_if "test -f /etc/chef/env/sphinx_snippets_udf_patched"
end
=end

script "install mysql source code" do
  interpreter "bash"
  user "root"
  cwd src_dir + "/" + base
  code <<-BASH
  sh BUILD/autorun.sh
  sudo ./configure --with-extra-charsets=complex \
  --with-charset=utf8 \
  --with-collation=utf8_general_ci \
  --enable-thread-safe-client \
  --enable-local-infile \
  --with-plugins=sphinx \
  --with-innodb \
  --prefix=/usr/local/mysql
  make
  make install
  BASH
=begin
cmake . -DWITH_SPHINX_STORAGE_ENGINE=1
-DCMAKE_INSTALL_PREFIX=#{target} -DINSTALL_LAYOUT=STANDALONE -DENABLED_PROFILING=ON
-DMYSQL_MAINTAINER_MODE=OFF -DWITH_DEBUG=OFF
=end
=begin
  code <<-BASH
  sh BUILD/autorun.sh
  cmake . -DCMAKE_INSTALL_PREFIX=#{target} \
  -DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
  -DDEFAULT_CHARSET=utf8 \
  -DDEFAULT_COLLATION=utf8_general_ci \
  -DWITH_EXTRA_CHARSETS:STRING=utf8 \
  -DWITH_MYISAM_STORAGE_ENGINE=1 \
  -DWITH_INNOBASE_STORAGE_ENGINE=1 \
  -DWITH_MEMORY_STORAGE_ENGINE=1 \
  -DWITH_READLINE=1 \
  -DENABLED_LOCAL_INFILE=1 \
  -DWITH_SPHINX_STORAGE_ENGINE=1 -DWITH_EMBEDDED_SERVER=1
  make install
  BASH
=end
  not_if { File.exist?(target) }
end
