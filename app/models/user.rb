class User < ApplicationRecord
  has_many :followee_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: :followee_id
  has_many :followees, through: :followee_relationships
  has_many :followers, through: :follower_relationships
  has_many :trips
  has_many :reviews
  has_many :ratings
  has_many :destinations, through: :ratings
  has_secure_password


  def sort_by_recent_trips(trips)
    trips.sort_by do |trip|
      trip.start_date
    end.reverse
  end

  def num_of_followers
    self.followers.size
  end

  def num_of_followees
    self.followees.size
  end

  def average_intensity
    self.trips.sum(&:intensity).to_f / self.trips.size
  end

  def self.intensity_level(n)
    if n <= 3
      "Chill"
    elsif n >= 4
      "ON FIRE"
    elsif n >= 3
      "Pretty Intense"
    end
  end
end
