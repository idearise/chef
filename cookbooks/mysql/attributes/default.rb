
src_dir = '/usr/local/src'
base = 'mysql-5.5.23'
tarball = '%s.tar.gz' % base

default[:mysql][:src_dir] = src_dir
default[:mysql][:base] = base
default[:mysql][:tarball] = tarball

default[:mysql][:tarball_url] = "http://ftp.jaist.ac.jp/pub/mysql/Downloads/MySQL-5.5/#{tarball}"
default[:mysql][:tarball_checksum] = 'b614481967dc146c148027b598397b54'
default[:mysql][:target] = '/usr/local/mysql'

src_dir = '/usr/local/src'
base = 'sphinx-2.0.4-release'
tarball = '%s.tar.gz' % base

default[:mysql][:sphinx][:src_dir] = src_dir
default[:mysql][:sphinx][:base] = base
default[:mysql][:sphinx][:tarball] = tarball

default[:mysql][:sphinx][:tarball_url] = "http://sphinxsearch.com/files/#{tarball}"
default[:mysql][:sphinx][:tarball_checksum] = 'b614481967dc146c148027b598397b54'


