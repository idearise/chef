
src_dir = '/usr/local/src'
version = '0.6.3'
base = 'node-v' + version
tarball = '%s.tar.gz' % base

#use :nodejs instead of :node since to prevent naming clash
default[:nodejs][:src_dir] = src_dir
default[:nodejs][:base] = base
default[:nodejs][:tarball] = tarball

default[:nodejs][:tarball_url] = "http://nodejs.org/dist/v#{version}/#{tarball}"
default[:nodejs][:tarball_checksum] = 'e9c72081c2a1141128e53f84dcba3f0e'
