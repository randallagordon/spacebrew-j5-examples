Spacebrew = require('./sb.js').Spacebrew
Five = require 'johnny-five'

server = 'sandbox.spacebrew.cc'
name = 'Spacebrew-J5'
description = 'Arduino LED via Johnny-Five'

sb = new Spacebrew.Client(server, name, description)
sb.addSubscribe 'onOff', 'boolean'
sb.connect()

board = new Five.Board()
led = {}
hilo = true

board.on 'ready', ->
  led = new Five.Led pin: 13

onBooleanMessage = (name, value) ->
  if hilo then led.on() else led.off()
  hilo = not hilo

sb.onBooleanMessage = onBooleanMessage
