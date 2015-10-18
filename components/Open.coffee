noflo = require 'noflo'
com = require 'serialport'

# @runtime noflo-nodejs

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Open the serial port'
  c.icon = 'cog'
  c.inPorts.add 'port',
    datatype: 'string'
    description: 'Port name or path'
    required: yes
  c.inPorts.add 'baudrate',
    datatype: 'number'
    description: 'Baudrate'
    required: yes
    default: 9600
  c.inPorts.add 'databits',
    datatype: 'number'
    description: 'Databits 5, 6, 7 or 8'
    required: yes
    values: [5, 6, 7, 8]
    default: 8
  c.inPorts.add 'stopbits',
    datatype: 'number'
    description: 'Stopbits 1 or 2'
    required: yes
    values: [1, 2]
    default: 1
  c.inPorts.add 'parity',
    datatype: 'string'
    description: 'Parity. none, even, mark, odd, space'
    required: yes
    values: ['none', 'even', 'mark', 'odd', 'space']
    default: 'none'
  c.inPorts.add 'buffersize',
    datatype: 'number'
    description: 'Buffersize. Default 255'
    required: yes
    default: 255
  c.inPorts.add 'parser',
    datatype: 'string'
    description: 'Parser. Default raw'
    required: yes
    default: 'raw'
  c.outPorts.add 'out',
    datatype: 'object'
    description: 'Serial port object'

  noflo.helpers.WirePattern c,
    in: 'port'
    params: [
      'baudrate'
      'databits'
      'stopbits'
      'parity'
      'buffersize'
      'parser'
    ]
    out: 'out'
    forwardGroups: true
  , (data, groups, out) ->
    _baudrate = c.params.baudrate
    _databits = c.params.databits
    _stopbits = c.params.stopbits
    _parity = c.params.parity
    _buffersize = c.params.buffersize
    _parser = c.params.parser

    options =
      baudrate: _baudrate
      databits: _databits
      stopbits: _stopbits
      parity: _parity
      buffersize: _buffersize
      parser: _parser

    if _parser is 'raw'
      options.parser = com.parsers.raw
    else
      options.parser = com.parsers.readline _parser

    serialPort = new com.SerialPort data, options

    serialPort.on 'open', ->
      out.send serialPort

  c
