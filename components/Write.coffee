noflo = require 'noflo'

# @runtime noflo-nodejs

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Write data to the serial port'
  c.icon = 'pencil'

  serialport = null
  message = ''
  drain = false

  c.inPorts.add 'serialport',
    datatype: 'string'
    description: 'Serialport object'
    required: yes
  c.inPorts.add 'message',
    datatype: 'string'
    description: 'Message'
    required: yes
  c.inPorts.add 'drain',
    datatype: 'boolean'
    description: "Waits until all output data has been transmitted"
    required: yes
  c.inPorts.add 'start',
    datatype: 'bang'
    required: yes

  c.inPorts.serialport.on 'data', (payload) ->
    serialport = payload
  c.inPorts.message.on 'data', (payload) ->
    message = payload
  c.inPorts.drain.on 'data', (payload) ->
    drain = payload
  c.inPorts.start.on 'data', ->
    if drain
      serialport.write message, ->
        serialport.drain
    else
      serialport.write message

  c
