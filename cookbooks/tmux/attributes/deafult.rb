
src_dir = '/usr/local/src'
base = 'tmux-1.6'
tarball = '%s.tar.gz' % base

default[:tmux][:src_dir] = src_dir
default[:tmux][:base] = base
default[:tmux][:tarball] = tarball

default[:tmux][:tarball_url] = "http://jaist.dl.sourceforge.net/project/tmux/tmux/tmux-1.6/#{tarball}"
default[:tmux][:tarball_checksum] = '3e37db24aa596bf108a0442a81c845b3'
