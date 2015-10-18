noflo = require 'noflo'

# @runtime noflo-nodejs

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Read the serial port'
  c.icon = 'cog'
  c.inPorts.add 'serialport',
    datatype: 'string'
    description: 'Serialport object'
    required: yes
  c.outPorts.add 'out',
    datatype: 'object'
    description: 'message'

  noflo.helpers.WirePattern c,
    in: 'serialport'
    out: 'out'
    forwardGroups: true
  , (data, groups, out) ->
    data.on 'data', (data) ->
      out.send data

  c
