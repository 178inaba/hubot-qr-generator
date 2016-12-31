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
# Nevertheless up to 900 characters should work in general.

url = require 'url'

baseUrl = 'https://api.qrserver.com/v1/create-qr-code'

module.exports = (robot) ->
  robot.respond /qr gen (.+)/i, (msg) ->
    data = msg.match[1]
    if data.length > 900
      msg.send 'Maximum length for data is 900 characters.'
      return

    msg.send makeUrl(data, robot.adapterName)

makeUrl = (data, adapterName) ->
  urlObj = url.parse(baseUrl)
  urlObj.query = {data: encodeURIComponent(data), size: '128x128'}
  adapterHack url.format(urlObj), adapterName

adapterHack = (url, adapterName) ->
  # If adapter name is empty, it returns the URL of the argument.
  return url if adapterName is null or adapterName is ''

  # Switch by adapter.
  switch adapterName.toLowerCase()
    when 'hipchat' then url + '#.png'
    else url
