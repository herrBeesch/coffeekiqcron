class CoffeeKiqCron extends CoffeeKiq
  find: (name)->
    @redis_client.hgetall "cron_job:#{name}"
exports.CoffeeKiqCron = CoffeeKiqCron