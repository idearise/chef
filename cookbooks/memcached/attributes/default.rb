
src_dir = '/usr/local/src'
base = 'memcached-1.4.10'
tarball = '%s.tar.gz' % base

default[:memcached][:src_dir] = src_dir
default[:memcached][:base] = base
default[:memcached][:tarball] = tarball

default[:memcached][:tarball_url] = "http://memcached.googlecode.com/files/#{tarball}"
default[:memcached][:tarball_checksum] = '8e18054ec5edfd96f7de87f02622052a'
