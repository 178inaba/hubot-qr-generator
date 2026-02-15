// Description:
//   Generate QR codes as PNG with size 128x128 pixels
//   Using service from [QR Code Generator](http://goqr.me/api/doc/create-qr-code/)
//
// Dependencies:
//   None
//
// Configuration:
//   None
//
// Commands:
//   hubot qr gen <data>
//
// Author:
//   eelcokoelewijn

// http(s)://api.qrserver.com/v1/create-qr-code/?data=[URL-encoded-text]&size=[pixels]x[pixels]
// Nevertheless up to 900 characters should work in general.

const baseUrl = 'https://api.qrserver.com/v1/create-qr-code';
const size = '128x128';

export default (robot) => {
  robot.respond(/qr gen (.+)/i, (msg) => {
    const data = msg.match[1];
    if (data.length > 900) {
      msg.send('Maximum length for data is 900 characters.');
      return;
    }

    const url = new URL(baseUrl);
    url.searchParams.set('data', data);
    url.searchParams.set('size', size);
    msg.send(url.toString());
  });
};
