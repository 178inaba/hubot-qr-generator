Helper = require('hubot-test-helper')
chai = require 'chai'
url = require 'url'
qs = require 'querystring'

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

  it 'escape url', ->
    dataUrl = 'https://github.com/'
    @room.user.say('alice', '@hubot qr gen ' + dataUrl).then =>
      expect(@room.messages).to.eql [
        ['alice', '@hubot qr gen ' + dataUrl]
        ['hubot', 'https://api.qrserver.com/v1/create-qr-code?data=https%3A%2F%2Fgithub.com%2F&size=128x128']
      ]

      qrUrl = @room.messages[1][1]
      urlObj = url.parse qrUrl
      qsObj = qs.parse urlObj.query
      expect(dataUrl).to.equal qsObj['data']

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
