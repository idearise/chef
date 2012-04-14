

bin = `which memcached`
con = 2048
threads = 4
mem = 512

default['memcached-configuration'][:bin] = bin
default['memcached-configuration'][:con] = con
default['memcached-configuration'][:threads] = threads
default['memcached-configuration'][:mem] = mem
