name "dev_env"
description "contains unsorted stuff for now."

run_list 'recipe[users-configuration]',
  'recipe[mysql::mysqlse]'