Description
===========
   setup the users for the machine. very simple, it sets up a user with its own group -- add user to the 'admins' group.
and adds the group to the sudoers list. also creates ~/deploy/.ssh/authorized_keys for your users.


Requirements
============
  for now, A centos6 client
    - this thing is setup on a centos6 machine -- and is probably platform specific,  so you might not want to use this cookbook unless you have centos6 clients as well

Attributes
==========

Usage
=====

 setup a data bag that looks like 

{
	"id":"deploy",
	"comment":"the deployer", 
	"gid": 1005, 
	"uid": 1005, 
	"shell":"/bin/bash",
	"password" : "$1$xTVIn0ot$AAr5.zMZtiapSd71x6mK8/",
	"authorized_keys" : { "stephen" : "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAxRvuBonwQVMJDw5ve+Xx/IsBKiuKsSCJ9m9GNNHxKDdca6yVmGbaSumVbNVooiZI6/0Kxd7uNDhX9+YeRqhaqNnNVgYOe56AkLth0EqpdwneEYquiETQ3+/aNRnk2vIWXx34mCiqFmxVo//sbEMllPKjxpSLuZqrZzmxd8S+gMVO+aU9h+rA6Zd8aYiLuKqnhv5qlOPfZkouhfHsKocwYb0NL1wQNGHV4P0EkB6zSguzJ36bghy6oHr4vAaX+GjEeWFAULJGK1zUKacxFgWaV7BMfmx5xDQym9qkAGCf5n9ZAsQDVTSgub3GYcXuYqhjMtw2dzJJbMtzIO8UlgZ5Xw== devpopol@Stephen-Paul-Suarezs-MacBook.local", "ian": "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAy6p0tOSNHn9UItCWH02OVadimRihxSLuAXZty8YKhruOzFQsElY5FIMHcMLQOTgTUC+sZqFDqm30c79fHqoNbzG0ZcOy8Gly2MAeEJfZic8JzyZNhTKeMgY69c6EMS1fdnMDxzhZR/zA+4RZtnNHSDGqp11MK6Tu7hsiSqI/fpGSgHUhHNanXC7B0+gODSrQmHSKZ0rqO6VFW2/sS4hRihI/E34bwzJStkOaVh91nl8AENMN6Q313hG3iJRbGAd4VwEL00hUtWvxY2BLG4tbZCRoMdEAVBzXO9JvOXgv/0kjXoeYDWwqSaXzVZKZeHSbdZmZwvfizykqxOJP8uBVDQ== devian@ian-bert-tusils-macbook.local"}
}
in ~/<chef-repo>/data_bags/users/deploy.json. the password key is generated using `openssl passwd -1 "theplaintextpassword"`, 
stick your own password in the password key. also stick your public keys under the authorized_keys -- they're mostly found under ~/.ssh/id_rsa.pub.

upload the bag to the server before using it by doing:
`knife data bag from file users deploy.json`