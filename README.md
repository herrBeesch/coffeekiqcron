# coffeekiqcron

Just an extension for https://github.com/nerdyglasses/coffeekiq/blob/master/README.md

##usage
npmRequire('coffeekiqcron').CoffeeKiqCron

## USAGE

You can add `coffeekiqcron: "~>0.0.1"` into your `package.json` or use `npm install coffeekiqcron`

```coffeescript
# Creates an instance of CoffeeKiq
CoffeeKiqCron = require('coffeekiqcron').CoffeeKiqCron

# Without Redis AUTH
coffeekiq = new CoffeeKiqCron "redis_port", "redis_host"

# With Redis AUTH
coffeekiq = new CoffeeKiqCron "redis_port", "redis_host", "redis_password"

# Enqueues a Job to redis namespace: "" and retry: false
coffeekiq.perform 'queue', 'WorkerClass', ['arg1', 'arg2']

# Enqueues a Job to redis with namespace: "myapp:staging" and retry: true
coffeekiq.perform 'queue', 'WorkerClass', ['arg1', 'arg2'],
  namespace: "myapp:staging"
  retry: true

# Finds a stored cron process
coffeekiq.find 'my_job', (err, result)->
  console.log err if err?
  console.dir result

```
