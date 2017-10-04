class Trip < ApplicationRecord
  belongs_to :user
  has_many :trip_destinations
  has_many :destinations, through: :trip_destinations
  has_many :trip_locations
  has_many :locations, through: :trip_locations
  has_many :reviews

  accepts_nested_attributes_for :destinations

  def location_names=(locations) #2
   locations.each do |location|
     if location.include?("locality")#regex finds locality
       city = location.split("span>").delete_if{|y| !y.include?("locality")}[0].chomp("</").split(">")[-1]
       country = location.split("span>").delete_if{|y| !y.include?("country-name")}[0].chomp("</").split(">")[-1]
     elsif location.include?("region")#regex finds region
       city = location.split("span>").delete_if{|y| !y.include?("region")}[0].chomp("</").split(">")[-1]
       country = location.split("span>").delete_if{|y| !y.include?("country-name")}[0].chomp("</").split(">")[-1]
     else
       city = nil
       country = nil
      #add error/validation
     end
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

  def first_three_destinations
    self.destinations.first(3)
  end

  def trip_duration
    if self.start_date
      (self.end_date - self.start_date).to_i + 1
    else
      nil
    end
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
        category: atts[:category], dest_location_name: atts[:dest_location_name])
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


  def self.trip_search_results(search_params, curr_user)
    # byebug
    if search_params[:qfriends] &&  search_params[:qfriends].to_i == 1
      curr_user_followees = curr_user.followees
      followees_trips = Trip.all.select {|trip| curr_user_followees.include?(trip.user)}
      followees_trips.select do |trip|
        trip.day_criteria_match?(search_params[:days]) && trip.location_criteria_match?(search_params[:location])
      end
    else
      Trip.all.select do |trip|
        trip.day_criteria_match?(search_params[:days]) && trip.location_criteria_match?(search_params[:location])
      end
    end
  end

  def day_criteria_match?(value)
    if value.empty?
      true
    else
      self.trip_duration == value.to_i
    end
  end

  def location_criteria_match?(value)
    if value.empty?
      true
    else
      self.locations.any? do |location|
        location.city == value
      end
    end
  end

end
