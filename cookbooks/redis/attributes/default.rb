
src_dir = '/usr/local/src'
base = 'redis-2.4.3'
tarball = '%s.tar.gz' % base

default[:redis][:src_dir] = src_dir
default[:redis][:base] = base
default[:redis][:tarball] = tarball

default[:redis][:tarball_url] = "http://redis.googlecode.com/files/#{tarball}"
default[:redis][:tarball_checksum] = '2511481019d1ba5ae18dea30ea77abb8'
