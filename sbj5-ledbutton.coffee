Spacebrew = require('./sb.js').Spacebrew
five = require 'johnny-five'

server = 'sandbox.spacebrew.cc'
name = 'SbJ5-LEDandButton'
description = 'Arduino LED and Button via Johnny-Five'

sb = new Spacebrew.Client(server, name, description)
sb.addSubscribe 'LED', 'boolean'
sb.addPublish 'Button', 'boolean', 'false'
sb.connect()

board = new five.Board()
led = {}
hilo = true

board.on 'ready', ->
  led = new five.Led pin: 13
  button = new five.Button pin: 2
  button.on 'down', ->
    sb.send('Button', 'boolean', 'true')
  button.on 'up', ->
    sb.send('Button', 'boolean', 'false')

onBooleanMessage = (name, value) ->
  if hilo then led.on() else led.off()
  hilo = not hilo

sb.onBooleanMessage = onBooleanMessage
