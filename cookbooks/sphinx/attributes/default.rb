
src_dir = '/usr/local/src'
base = 'sphinx-2.0.4-release'
tarball = '%s.tar.gz' % base

default[:sphinx][:src_dir] = src_dir
default[:sphinx][:base] = base
default[:sphinx][:tarball] = tarball

default[:sphinx][:tarball_url] = "http://sphinxsearch.com/files/#{tarball}"
default[:sphinx][:tarball_checksum] = 'b614481967dc146c148027b598397b54'
