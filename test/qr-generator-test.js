const Helper = require('hubot-test-helper');
const chai = require('chai');
const url = require('url');
const qs = require('querystring');

const { expect } = chai;

const helper = new Helper('../src/qr-generator.js');

describe('qr-generator', function() {
  beforeEach(function() {
    this.room = helper.createRoom();
  });

  afterEach(function() {
    this.room.destroy();
  });

  it('generate qr code url', function() {
    return this.room.user.say('alice', '@hubot qr gen hello').then(() => {
      expect(this.room.messages).to.eql([
        ['alice', '@hubot qr gen hello'],
        ['hubot', 'https://api.qrserver.com/v1/create-qr-code?data=hello&size=128x128']
      ]);
    });
  });

  it('escape url', function() {
    const dataUrl = 'https://github.com/';
    return this.room.user.say('alice', '@hubot qr gen ' + dataUrl).then(() => {
      expect(this.room.messages).to.eql([
        ['alice', '@hubot qr gen ' + dataUrl],
        ['hubot', 'https://api.qrserver.com/v1/create-qr-code?data=https%3A%2F%2Fgithub.com%2F&size=128x128']
      ]);

      const qrUrl = this.room.messages[1][1];
      const urlObj = url.parse(qrUrl);
      const qsObj = qs.parse(urlObj.query);
      expect(dataUrl).to.equal(qsObj['data']);
    });
  });

  it('for hipchat', function() {
    this.room.robot.adapterName = 'hipchat';
    return this.room.user.say('alice', '@hubot qr gen hello').then(() => {
      expect(this.room.messages).to.eql([
        ['alice', '@hubot qr gen hello'],
        ['hubot', 'https://api.qrserver.com/v1/create-qr-code?data=hello&size=128x128#.png']
      ]);
    });
  });

  it('for hipchat2', function() {
    this.room.robot.adapterName = 'hipchat2';
    return this.room.user.say('alice', '@hubot qr gen hello').then(() => {
      expect(this.room.messages).to.eql([
        ['alice', '@hubot qr gen hello'],
        ['hubot', 'https://api.qrserver.com/v1/create-qr-code?data=hello&size=128x128#.png']
      ]);
    });
  });

  it('over 900 chars', function() {
    let data = '';
    for (let i = 0; i <= 900; i++) { data += 'a'; }
    return this.room.user.say('alice', '@hubot qr gen ' + data).then(() => {
      expect(this.room.messages).to.eql([
        ['alice', '@hubot qr gen ' + data],
        ['hubot', 'Maximum length for data is 900 characters.']
      ]);
    });
  });
});
