Helper = require('hubot-test-helper')
chai = require 'chai'

expect = chai.expect

helper = new Helper('../src/qr-generator.coffee')

describe 'qr-generator', ->
  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  it 'generate qr code url', ->
    @room.user.say('alice', '@hubot qr gen hello').then =>
      expect(@room.messages).to.eql [
        ['alice', '@hubot qr gen hello']
        ['hubot', 'https://api.qrserver.com/v1/create-qr-code?data=hello&size=128x128']
      ]

  it 'for hipchat', ->
    @room.robot.adapterName = 'hipchat'
    @room.user.say('alice', '@hubot qr gen hello').then =>
      expect(@room.messages).to.eql [
        ['alice', '@hubot qr gen hello']
        ['hubot', 'https://api.qrserver.com/v1/create-qr-code?data=hello&size=128x128#.png']
      ]

  it 'over 900 chars', ->
    data = ''
    data += 'a' for i in [0..900]
    @room.user.say('alice', '@hubot qr gen ' + data).then =>
      expect(@room.messages).to.eql [
        ['alice', '@hubot qr gen ' + data]
        ['hubot', 'Maximum length for data is 900 characters.']
      ]
