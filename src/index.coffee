
# dependencies
require './App'

# page template
module.exports = ->
  doctype 5
  html lang: 'en', ->
    head ->
      title 'WebGradients for Lemon'
    body ->
      site.App()
