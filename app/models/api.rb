require 'pry'
require 'google_places'

  client = GooglePlaces::Client.new('AIzaSyA-I5ocFX1PNZmc-QRxy1q1MFwAm09yDqE')
  client.spots(-33.8670522, 151.1957362)
  byebug
  "hi"
