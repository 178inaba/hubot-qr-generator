# Description:
#   Generate QR codes as PNG with size 128x128 pixels
#   Using service from [QR Code Generator](http://goqr.me/api/doc/create-qr-code/)
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot qr gen <data>
#
# Author:
#   eelcokoelewijn


# http(s)://api.qrserver.com/v1/create-qr-code/?data=[URL-encoded-text]&size=[pixels]x[pixels]
module.exports = (robot) ->
 robot.respond /qr gen (.+)/i, (msg) ->
  data = msg.match[1]
  msg.send "https://api.qrserver.com/v1/create-qr-code/?data=#{encodeURIComponent(data)}&size=128x128"
