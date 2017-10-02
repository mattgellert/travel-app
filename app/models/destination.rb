class Destination < ApplicationRecord
  belongs_to :location
  has_many :trip_destinations
  has_many :trips, through: :trip_destinations
  has_many :ratings
  #accepts_nested_attributes_for :ratings

  def self.category
    ["restaurant", "hotel", "attraction"]
  end
end
