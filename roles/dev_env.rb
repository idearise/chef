name "dev_env"
description "contains unsorted stuff for now."

run_list 'recipe[git]',
  'recipe[mysql::mysqlse]',
  'recipe[sphinx]',
  'recipe[memcached]','recipe[memcached-configuration]',
  'recipe[node.js]',
  'recipe[passenger]',
  'recipe[users-configuration]'