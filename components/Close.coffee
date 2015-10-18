noflo = require 'noflo'

# @runtime noflo-nodejs

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Close the serial port'
  c.icon = 'close'
  c.inPorts.add 'serialport',
    datatype: 'string'
    description: 'Serialport object'
    required: yes
  c.inPorts.add 'stop',
    datatype: 'bang'
    required: yes
  c.outPorts.add 'error',
    datatype: 'string'
    description: 'error'

  noflo.helpers.WirePattern c,
    in: [
      'serialport'
      'stop'
    ]
    out: 'error'
    forwardGroups: true
  , (data, groups, out) ->
    if data.stop
      data.serialport.close (err) ->
        error.send err if err?

  c
