# Serialport for NoFlo
[![Build Status](https://secure.travis-ci.org/razueroh/noflo-serialport.png?branch=master)](http://travis-ci.org/razueroh/noflo-serialport)

This package provides utility components to access serial ports in the NoFlo Node.js runtime. Based on [node-serialport](https://github.com/voodootikigod/node-serialport).

## Package installation

    npm install noflo-serialport --save

## Basic usage

- Install and set up a [noflo-nodejs runtime](https://github.com/noflo/noflo-nodejs#noflo-nodejs-runtime-environment). You can do it following [this guide](http://docs.flowhub.io/article/84-getting-started-node-js)
- Install the component library locally with `npm`
- Start the runtime and log into [Flowhub](http://app.flowhub.io). The runtime should show up
- Connect your serial device to the computer
- Create a Flowhub project
- To open the serial port add a `serialport/Open` node and configure the port parameters. The output of the component is a serialport object
- To write or read to the port add a `serialport/Write` and a `serialport/Read` nodes. The `serialport` input must be connected to the output of the `serialport/Open` node
