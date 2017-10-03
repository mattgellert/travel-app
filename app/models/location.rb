class Location < ApplicationRecord
  has_many :destinations
  has_many :trip_locations
  has_many :trips, through: :trip_locations

  def make_location_name
    "#{self.try(:city)}, #{self.try(:country)}"
  end
end
