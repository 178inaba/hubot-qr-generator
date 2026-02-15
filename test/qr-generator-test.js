import { expect } from 'chai';
import { Robot, TextMessage, User } from 'hubot';
import DummyAdapter from './doubles/DummyAdapter.js';
import script from '../src/qr-generator.js';

describe('qr-generator', function() {
  let robot;
  let sends;

  beforeEach(async function() {
    robot = new Robot(DummyAdapter, false, 'hubot');
    await robot.loadAdapter();

    sends = [];
    robot.adapter.on('send', (envelope, ...strings) => {
      sends.push(...strings);
    });

    script(robot);
    await robot.run();
  });

  afterEach(async function() {
    await robot.shutdown();
  });

  async function say(text) {
    const user = new User('alice', { name: 'alice', room: '#test' });
    const message = new TextMessage(user, text, '1');
    await robot.receive(message);
  }

  it('generate qr code url', async function() {
    await say('@hubot qr gen hello');
    expect(sends).to.eql([
      'https://api.qrserver.com/v1/create-qr-code?data=hello&size=128x128'
    ]);
  });

  it('escape url', async function() {
    await say('@hubot qr gen https://github.com/');
    expect(sends).to.eql([
      'https://api.qrserver.com/v1/create-qr-code?data=https%3A%2F%2Fgithub.com%2F&size=128x128'
    ]);
  });

  it('over 900 chars', async function() {
    const data = 'a'.repeat(901);
    await say('@hubot qr gen ' + data);
    expect(sends).to.eql([
      'Maximum length for data is 900 characters.'
    ]);
  });
});
