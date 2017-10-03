class Destination < ApplicationRecord
  belongs_to :location
  has_many :trip_destinations
  has_many :trips, through: :trip_destinations
  has_many :ratings
  has_many :user_raters, class_name: "User", through: :ratings
  accepts_nested_attributes_for :ratings


  def dest_average_rating
    sum = self.ratings.sum(&:stars)
    sum.to_f / self.ratings.size
  end



  def dest_location_name=(name)
    city = name.split(/\s*,\s*/)[0]
    country = name.split(/\s*,\s*/)[1]
    self.location = Location.find_or_create_by(city: city, country: country)
  end

  def dest_location_name
    if self.location
      "#{self.location.city}, #{self.location.country}"
    else
      nil
    end
  end

  def self.category
    ["restaurant", "hotel", "attraction"]
  end

  #finds destination's owner rating object
  def owner_rating(trip_obj)
    self.ratings.find {|rating| rating.user_id == trip_obj.user_id}
  end

end
