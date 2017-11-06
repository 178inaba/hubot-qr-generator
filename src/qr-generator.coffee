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
mdOut = process.env.HUBOT_QR_MARKDOWN == 'true'
baseUrl = 'https://api.qrserver.com/v1/create-qr-code'
size = '128x128'

module.exports = (robot) ->
  robot.respond /qr gen (.+)/i, (msg) ->
    data = msg.match[1]
    if data.length > 900
      msg.send 'Maximum length for data is 900 characters.'
      return

    urlObj = makeUrlObj data
    hackUrlObj = adapterHack urlObj, robot.adapterName
    mapUrl = url.format hackUrlObj
    if mdOut
      msg.send "![mapUrl](#{mapUrl})"
    else
      msg.send mapUrl

makeUrlObj = (data) ->
  urlObj = url.parse baseUrl
  urlObj.query = {data: data, size: size}
  return urlObj

adapterHack = (urlObj, adapterName) ->
  # If the adapter name is null, the URL object of the argument is returned unchanged.
  return urlObj if adapterName is null

  # Switch by adapter.
  if /hipchat/.test adapterName.toLowerCase()
    urlObj.hash = '.png'

  return urlObj
