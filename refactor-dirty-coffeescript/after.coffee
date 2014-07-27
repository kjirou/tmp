class Photo
  @id = null
  @url = null
  @alt = null

  constructor: ({@id, @url, @alt}) ->


class PhotoView
  @$el = null
  @$_img = null
  @_photo = null

  constructor: (@_photo) ->

  render: ->
    @$el = $ '<li>'

    $a = $('<a>')
      .attr({
        id: 'photo_' + @_photo.id
        href: @_photo.url
      })

    @$_img = $('<img>')
      .attr({
        src: @_photo.url
        alt: @_photo.alt
      })

    $a.append @$_img
    @$el.append $a

    @_attachClickEvent()

  _attachClickEvent: ->
    @$el.click (e) =>
      e.preventDefault()
      @$_img.attr 'src', @_photo.url + '.grayscaled.jpg'
      false


class PhotoListView
  @$el = null
  @_photos = []

  constructor: (@_photos) ->

  _createRoot: -> $('<ul>').attr('id', 'photo-list')

  render: ->
    @$el = @_createRoot()
    for photo in @_photos
      photoView = new PhotoView photo
      photoView.render()
      @$el.append photoView

  renderForFailure:
    @$el = @_createRoot()
    @$el.append '<li>Failed to fetch photos.</li>'


# バックエンドなんだけど、view-list と密結合はやばい
# クライアント側でデータ挿入できなくなるから
class PhotoListBackend
  @_photoDataList

  request: ->


$(document).ready ->

  $.ajax
    url: '/photos'
    type: 'GET'
    contentType: 'application/json'
    onSuccess: (response) =>
      for photo in response.photos
        node = $(photoHTML(photo)).appendTo($("#photos-list"))

        node.on('click', (e) =>
          e.preventDefault()
          node.find('img').prop('src', 
            photo.url + '.grayscaled.jpg')
        )
    onFailure: =>
      $("#photo-list").append("<li>
                                 Failed to fetch photos.
                              </li>")





