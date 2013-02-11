Spacebrew = require('./sb.js').Spacebrew
Five = require 'johnny-five'

server = 'sandbox.spacebrew.cc'
name = 'SbJ5-Button'
description = 'Arduino button via Johnny-Five'

sb = new Spacebrew.Client(server, name, description)
sb.addPublish 'Button', 'boolean', 'false'
sb.connect()

board = new Five.Board()

board.on 'ready', ->
  button = new Five.Button pin: 2
  button.on 'down', ->
    sb.send('Button', 'boolean', 'true')
  button.on 'up', ->
    sb.send('Button', 'boolean', 'false')
