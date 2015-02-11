class CoffeeKiqCron extends CoffeeKiq
  find: (name)->
    CoffeeKiq::redis_client.hgetall "cron_job:#{name}"
exports.CoffeeKiqCron = CoffeeKiqCron