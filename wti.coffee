#!/usr/bin/env coffee
moment = require 'moment-timezone'
Table = require 'cli-table'

# TODO: parameterize
from_tz = 'Asia/Bangkok'
to_tz = 'America/Los_Angeles'
days = 2
sleepingStart = 23
sleepingEnd = 9

here = moment.tz(from_tz)

hereToThere = (h) -> h.clone().tz(to_tz)
there = hereToThere here

times = [ [here, hereToThere here] ]
for i in [1...23*days]
  time = here.clone().add(i, 'hour')
  there = hereToThere time
  if sleepingEnd < time.hour() < sleepingStart and
      sleepingEnd < there.hour() < sleepingStart
    times.push [time, hereToThere time]

format = 'ddd ha'

# TODO: format with spaces or commas (so its not completely ugly with non mono width fonts)
table = new Table head: [from_tz, to_tz]
table.push [h.format(format), t.format(format)] for [h, t] in times

console.log(table.toString())
