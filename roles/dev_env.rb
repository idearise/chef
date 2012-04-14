name "dev_env"
description "contains unsorted stuff for now."

run_list *[
  'recipe[screen]',
  'recipe[git]',
  'recipe[mysql::mysqlse]', 'recipe[mysql-configuration]',
  'recipe[sphinx]',
  'recipe[memcached]','recipe[memcached-configuration]',
  'recipe[node.js]',
  'recipe[passenger]',
  'recipe[rbenv]',
  'recipe[redis]','recipe[redis-configuration]',
  'recipe[postgresql]',
  'recipe[users-configuration]'
]