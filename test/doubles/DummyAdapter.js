import { Adapter } from 'hubot';

class DummyAdapter extends Adapter {
  constructor (robot) {
    super(robot);
    this.name = 'DummyAdapter';
  }

  async send (envelope, ...strings) {
    this.emit('send', envelope, ...strings);
  }

  async reply (envelope, ...strings) {
    this.emit('reply', envelope, ...strings);
  }

  async run () {
    this.emit('connected');
  }

  async close () {
    this.emit('closed');
  }
}

export default {
  use (robot) {
    return new DummyAdapter(robot);
  }
};
