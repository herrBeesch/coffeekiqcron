CoffeeKiq = require('coffeekiq').CoffeeKiq
class CoffeeKiqCron extends CoffeeKiq
  find: (name, cb)->
    @.connect() unless @.connected
    result = @redis_client.hgetall "cron_job:#{name}", cb
exports.CoffeeKiqCron = CoffeeKiqCron