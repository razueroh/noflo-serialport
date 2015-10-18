noflo = require 'noflo'

# @runtime noflo-nodejs

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Send a message if error occurs'
  c.icon = 'warning'
  c.inPorts.add 'serialport',
    datatype: 'string'
    description: 'Serialport object'
    required: yes
  c.outPorts.add 'out',
    datatype: 'string'
    description: 'Error message'

  noflo.helpers.WirePattern c,
    in: 'serialport'
    out: 'out'
    forwardGroups: true
  , (data, groups, out) ->
    data.on 'error', (error) ->
      out.send error
    data.on 'close', ->
      out.send "Closing serial port"

  c
