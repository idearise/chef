
src_dir = '/usr/local/src'
#Commented are in 5.5; currently sphinx latest version has a problem with compiling mysql sphinx engine against it
#base = 'mysql-5.5.23'
base = 'mysql-5.1.62'
tarball = '%s.tar.gz' % base

default[:mysql][:src_dir] = src_dir
default[:mysql][:base] = base
default[:mysql][:tarball] = tarball

#Commented are in 5.5; currently sphinx latest version has a problem with compiling mysql sphinx engine against it
#default[:mysql][:tarball_url] = "http://ftp.jaist.ac.jp/pub/mysql/Downloads/MySQL-5.5/#{tarball}"
#default[:mysql][:tarball_checksum] = 'b614481967dc146c148027b598397b54'

default[:mysql][:tarball_url] = "http://ftp.jaist.ac.jp/pub/mysql/Downloads/MySQL-5.1/#{tarball}"
default[:mysql][:tarball_checksum] = '58843ac04d3e8bb6ff973938e7e88a28'
default[:mysql][:target] = '/usr/local/mysql'

src_dir = '/usr/local/src'
base = 'sphinx-2.0.4-release'
tarball = '%s.tar.gz' % base

default[:mysql][:sphinx][:src_dir] = src_dir
default[:mysql][:sphinx][:base] = base
default[:mysql][:sphinx][:tarball] = tarball

default[:mysql][:sphinx][:tarball_url] = "http://sphinxsearch.com/files/#{tarball}"
default[:mysql][:sphinx][:tarball_checksum] = 'b614481967dc146c148027b598397b54'


