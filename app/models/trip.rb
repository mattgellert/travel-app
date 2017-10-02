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

end
