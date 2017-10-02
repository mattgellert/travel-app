# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
matt = User.create(name: "Matt")
christina = User.create(name: "Christina")

matt_follows_christina = Relationship.create(follower_id: matt.id, followee_id: christina.id)

greece = Location.create(city: "Athens", country: "Greece")
santorini = Location.create(city: "Santorini", country: "Greece")
sf = Location.create(city: "San Francisco", country: "United States")
binyamina = Location.create(city: "Binyamina", country: "Israel")

greece_trip = Trip.create(title: "Summer Greece", days: 5, intensity: 5, user_id: christina.id)
sf_trip = Trip.create(title: "Tech in SF", days: 3, intensity: 3, user_id: christina.id)
israel_trip = Trip.create(title: "Summer in Israel", days: 6, intensity: 4, user_id: matt.id)

TripLocation.create(trip_id: greece_trip.id, location_id: greece.id)
TripLocation.create(trip_id: greece_trip.id, location_id: santorini.id)

acropolis = Destination.create(name: "Acropolis", description: "Greek stuff", address: "greece address", category: "attraction", location_id: greece.id)
hadrian_arch = Destination.create(name: "Hadrian's Arch", description: "Greek stuff2", address: "greece address2", category: "attraction", location_id: greece.id)
coit_tower = Destination.create(name: "Coit Tower", description: "SF stuff", address: "SF address", category: "attraction", location_id: sf.id)
dead_sea = Destination.create(name: "Dead Sea", description: "Israel stuff", address: "Israel address", category: "attraction", location_id: binyamina.id)
golan_heights = Destination.create(name: "Golan Heights", description: "Israel stuff2", address: "Israel address2", category: "attraction", location_id: binyamina.id)
sf_rest = Destination.create(name: "SF restaurant", description: "SF stuff2", address: "SF address2", category: "restaurant", location_id: sf.id)
oia = Destination.create(name: "OIA", description: "its the OIA", address: "where the OIA is", category: "attraction", location_id: santorini.id)

TripDestination.create(trip_id: greece_trip.id, destination_id: acropolis.id)
TripDestination.create(trip_id: greece_trip.id, destination_id: hadrian_arch.id)
TripDestination.create(trip_id: sf_trip.id, destination_id: coit_tower.id)
TripDestination.create(trip_id: sf_trip.id, destination_id: sf_rest.id)
TripDestination.create(trip_id: israel_trip.id, destination_id: dead_sea.id)
TripDestination.create(trip_id: israel_trip.id, destination_id: golan_heights.id)
TripDestination.create(trip_id: greece_trip.id, destination_id: oia.id)

acropolis_rating = Rating.create(stars: 4, note: "blah", destination_id: acropolis.id)
acropolis_rating2 = Rating.create(stars: 5, note: "blahblah", destination_id: acropolis.id)
dead_sea_rating = Rating.create(stars: 5, note: "blah", destination_id: dead_sea.id)
sf_rest_rating = Rating.create(stars: 1, note: "terrible", destination_id: sf_rest.id)

greece_trip_review = Review.create(trip_id: greece_trip.id, user_id: christina.id, comment: "good trip", vote: 1)
greece_trip_review2 = Review.create(trip_id: greece_trip.id, user_id: matt.id, comment: "really good trip", vote: 1)
sf_trip_review = Review.create(trip_id: sf_trip.id, user_id: christina.id, comment: "ok trip", vote: 1)
israel_trip_review = Review.create(trip_id: israel_trip.id, user_id: matt.id, comment: "good trip", vote: 1)
