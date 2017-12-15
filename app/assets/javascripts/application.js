// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery

// document.addEventListener('DOMContentLoaded', function() {

  function initialize() {
    let inputs = Number(document.getElementById('trip_duration').value)
    for (let i = 0; i <= inputs; i++) {
        initMap(i)
    }
  }

  function initMap(n) {
    let map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: -33.8688, lng: 151.2195},
      zoom: 13
    })
    let card = document.getElementById(`pac-card-${n}`)
    let input = document.getElementById(`pac-input-${n}`)
    let autocomplete = new google.maps.places.Autocomplete(input)
    autocomplete.bindTo('bounds', map)
    autocomplete.addListener('place_changed', function() {
      let place = autocomplete.getPlace()

      $(`#google_location_${n}`).val(place.adr_address)
      $(`#google_address_${n}`).val(place.formatted_address)
      $(`#google_name_${n}`).val(place.name)

      var elem1 = place.photos[0]
      var elem2 = place.photos[1]
      var elem3 = place.photos[2]
      var elems = [elem1, elem2, elem3]
      elems.forEach(function(elem, index){
        if(elem != undefined){
          let photo_url = elem.getUrl({maxWidth: 5000, maxHeight: 5000})
          $(`#google_photo_${index}_${n}`).val(photo_url)
        }
        else {
          $(`#google_photo_${index}_${n}`).val("")
        }
      })

      let rating = 0
      let review = "something"
      place.reviews.forEach(function(elem){
        if(rating < elem.rating){
          rating = elem.rating
          review = elem.text
        }
      })
      $(`#google_desc_${n}`).val(review)
    })
  }




// })
