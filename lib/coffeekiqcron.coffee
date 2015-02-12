CoffeeKiq = require('coffeekiq').CoffeeKiq
crypto = require 'crypto'
class CoffeeKiqCron extends CoffeeKiq
  constructor: (redis_port, redis_host, redis_password = null) ->
    super(redis_port, redis_host, redis_password)
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
        self.perform queue, result.klass, msg.args
      else
        self.emit 'enqueue:error'
    return "trying to enqueue #{name}"
  perform: (queue, klass, args, options = {}) ->
    self = @
    if !options.namespace? then namespace = "" else namespace = options.namespace
    if !options.retry? then retry = false else retry = true
    crypto.randomBytes 12, (ex, buf) ->
      throw new Error "could not create random bytes for jid" if ex?
      payload = JSON.stringify
        queue: queue
        class: klass
        args: args
        jid: buf.toString 'hex'
      self.redis_client.sadd(_.compact([namespace, "queues"]).join(":"), queue)
      self.redis_client.lpush(_.compact([namespace, "queue", queue]).join(":"), payload)
      self.emit 'perform:done' 
      return true
exports.CoffeeKiqCron = CoffeeKiqCron