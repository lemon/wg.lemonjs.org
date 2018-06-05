
# stylesheets
require './css/App.styl'

# dependencies
require 'lemonjs-wg'
require 'lemonjs-lui/Footer'
require 'lemonjs-lui/Grid'
require 'lemonjs-lui/Header'
require 'lemonjs-lui/Input'

# load gradient names
gradients = require 'lemonjs-wg/list.json'

# component
module.exports = lemon.Component {
  package: 'site'
  name: 'App'
  id: 'app'

  data: {
    active_gradient: null
    gradients: gradients
    query: ''
  }

  methods: {

    onClickItem: (e) ->
      @active_gradient = e.currentTarget.getAttribute 'title'

    onSearch: (e) ->
      clearTimeout @timeout_id if @timeout_id
      @timeout_id = setTimeout ( =>
        @query = @$search.value
      ), 300
  }

  template: (data) ->

    lui.Header {
      logo: 'lemon + webgradients'
      nav: [
        {href: 'https://github.com/lemon/wg.lemonjs.org', text: 'website'}
        {href: 'https://github.com/lemon/lemonjs-wg', text: 'library'}
      ]
    }

    div '.search', ->
      lui.Input {
        ref: '$search'
        label: 'search for a gradient'
        onKeyUp: 'onSearch'
      }

    div '.gradients', ->
      div _on: 'query', _template: (query, data) ->
        items = []
        for name in data.gradients when name.toLowerCase().indexOf(query) > -1
          do (name) ->
            items.push {
              icon: -> wg[name] {position: 'absolute'}
              name: name
            }
        if items.length is 0
          div '.no-match', ->
            'No gradients matching your search'
        else
          lui.Grid {
            items: items
            onClickItem: 'onClickItem'
          }
          div _on: 'active_gradient', _template: (gradient, data) ->
            if gradient
              wg[gradient] {position: 'fixed'}

    lui.Footer {}, ->
      div ->
        'Released under the MIT License'
      div ->
        '© Copyright 2018 Shenzhen239'

}
