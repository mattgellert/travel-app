class Trip < ApplicationRecord
  belongs_to :user
  has_many :trip_destinations
  has_many :destinations, through: :trip_destinations
  has_many :trip_locations
  has_many :locations, through: :trip_locations
  has_many :reviews
end
