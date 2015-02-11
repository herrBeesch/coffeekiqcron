CoffeeKiq = require('coffeekiq').CoffeeKiq
class CoffeeKiqCron extends CoffeeKiq
  find: (name, cb)->
    @.connect() unless @.connected
    result = @redis_client.hgetall "cron_job:#{name}", cb
  enqueue: (name)->
    self = @
    @find name, (err, result)->
      unless err?
        msg = JSON.parse result.message
        if result.queue?
          queue = result.queue
        else
          queue = 'default'
        coffeekiq.perform queue, result.klass, msg.args
      else
        console.log err
    return "trying to enqueue #{name}"
exports.CoffeeKiqCron = CoffeeKiqCron