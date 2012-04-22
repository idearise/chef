name "sortary-env"
description "Sortary server"

run_list *%w[
  recipe[redisio::install]
  recipe[redisio::enable]
]