$(document).ready ->
  photoHTML = (photo) =>
    "<li>
       <a id='photo_#{photo.id}' href='#{photo.url}'>
         <img src='#{photo.url}' alt='#{photo.alt}' />
       </a>
    </li>"

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
