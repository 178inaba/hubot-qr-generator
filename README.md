# hubot-qr-generator

[![Build Status](https://travis-ci.org/178inaba/hubot-qr-generator.svg?branch=master)](https://travis-ci.org/178inaba/hubot-qr-generator)

Generates QR codes for your Hubot, using service from [QR Code Generator](http://goqr.me/api/doc/create-qr-code/)

See [`src/qr-generator.coffee`](src/qr-generator.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-qr-generator --save`

Then add **hubot-qr-generator** to your `external-scripts.json`:

```json
["hubot-qr-generator"]
```

## Sample Interaction

```
user1>> hubot qr gen http://www.google.com
hubot>> https://api.qrserver.com/v1/create-qr-code/?data=http%3A%2F%2Fwww.google.com&size=128x128
```
