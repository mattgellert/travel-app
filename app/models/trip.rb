class Trip < ApplicationRecord
  belongs_to :user
  has_many :trip_destinations
  has_many :destinations, through: :trip_destinations
  has_many :trip_locations
  has_many :locations, through: :trip_locations
  has_many :reviews

  accepts_nested_attributes_for :destinations

  def location_names=(locations)
    locations.delete_if(&:empty?)
    locations.each do |location|
      city = location.split(/\s*,\s*/)[0]
      country = location.split(/\s*,\s*/)[1]
      self.locations << Location.find_or_create_by(city: city, country: country)
    end
  end

  def location_names
    if self.locations
      self.locations.map do |location|
        "#{self.location.city}, #{self.location.country}"
      end
    end
  end

  def trip_duration
    (self.end_date - self.start_date).to_i + 1
  end

  #returns a trip's destinations array by day
  def trip_destinations_by_day(day)
    self.trip_destinations.where(day: day).collect do |t_d|
      t_d.destination
    end
  end

  def destinations_attributes=(destinations)
    destinations.delete_if do |n, at| at[:name].empty? end
    destinations.each do |num, atts|
      new_dest = Destination.create(
        name: atts[:name],
        description: atts[:description],
        address: atts[:address],
        category: atts[:category], location_id: 1)
        # byebug
      rating = Rating.create(stars: atts[:ratings_attributes]["0"
        ][:stars], note: atts[:ratings_attributes]["0"][:note], user_id: self.user.id)
      new_dest.ratings << rating
      self.destinations << new_dest
      trip_dest = TripDestination.find_by(trip_id: self.id, destination_id: new_dest.id)
      trip_dest.day = atts[:day]
      trip_dest.save
    end
  end

end
