class Destination < ApplicationRecord
  belongs_to :location
  has_many :trip_destinations
  has_many :trips, through: :trip_destinations
  has_many :ratings
  has_many :user_raters, class_name: "User", through: :ratings
  accepts_nested_attributes_for :ratings

  #given a trip obj, which trip date does the destination belong to
  def day(trip)
    td = TripDestination.find_by(trip_id: trip.id, destination_id: self.id)
    td.try(:day)
  end


  def dest_average_rating
    sum = self.ratings.sum(&:stars)
    rating = sum.to_f / self.ratings.size
    ((rating * 2).round / 2)*10.round
  end


  def dest_location_name=(name)
    if name.include?("locality")#regex finds locality
      city = name.split("span>").delete_if{|y| !y.include?("locality")}[0].chomp("</").split(">")[-1]
      country = name.split("span>").delete_if{|y| !y.include?("country-name")}[0].chomp("</").split(">")[-1]
    elsif name.include?("region")#regex finds region
      city = name.split("span>").delete_if{|y| !y.include?("region")}[0].chomp("</").split(">")[-1]
      country = name.split("span>").delete_if{|y| !y.include?("country-name")}[0].chomp("</").split(">")[-1]
    else
      city = nil
      country = nil
     #add error/validation
    end
    self.location = Location.find_or_create_by(city: city, country: country)
  end

  # def dest_location_name=(name)
  #   city = name.split(/\s*,\s*/)[0]
  #   country = name.split(/\s*,\s*/)[1]
  #   self.location = Location.find_or_create_by(city: city, country: country)
  # end

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
    find = self.ratings.find {|rating| rating.user_id == trip_obj.user_id}
  end

  def self.destination_sort_by_rating(destinations)
    destinations.sort_by {|dest| dest.dest_average_rating * -1}
  end

  def self.dest_search_results(search_params)
    # byebug
    Destination.all.select do |dest|
      dest.category_criteria_match?(search_params[:qcategory]) && dest.location_criteria_match?(search_params[:qlocation]) && dest.name_criteria_match?(search_params[:qname])
    end
  end

  def name_criteria_match?(value)
    value.empty? ? true : (self.name == value)
  end

  def category_criteria_match?(value)
    value.empty? ? true : (self.category == value)
  end

  def location_criteria_match?(value)
    value.empty? ? true : (self.location.city == value)
  end

  def user_destination_rating(user)
    self.ratings.select {|rating| rating.user == user}.first
  end

end
