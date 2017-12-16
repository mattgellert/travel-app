class Trip < ApplicationRecord
  belongs_to :user
  has_many :trip_destinations
  has_many :destinations, through: :trip_destinations
  has_many :trip_locations
  has_many :locations, through: :trip_locations
  has_many :reviews

  validates :title, :blurb, :start_date, :end_date, :intensity, presence: true

  accepts_nested_attributes_for :destinations

  def location_names=(locations) #2
   locations.delete_if {|location| location.empty? || location.nil?}
   locations.each do |location|
     if location.include?("locality")
       city = location.split("span>").delete_if{|y| !y.include?("locality")}[0].chomp("</").split(">")[-1]
       country = location.split("span>").delete_if{|y| !y.include?("country-name")}[0].chomp("</").split(">")[-1]
     elsif location.include?("region")
       city = location.split("span>").delete_if{|y| !y.include?("region")}[0].chomp("</").split(">")[-1]
       country = location.split("span>").delete_if{|y| !y.include?("country-name")}[0].chomp("</").split(">")[-1]
     elsif location.include?("country-name")
       city = "City N/A"
       country = location.split("span>").delete_if{|y| !y.include?("country-name")}[0].chomp("</").split(">")[-1]
     elsif location.include?(", ")
       city = location.city
       country = location.country
     else
       city = nil
       country = nil
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
        new_dest = Destination.find_by(name: atts[:name])
        if new_dest
          new_dest.update(
            description: atts[:description],
            address: atts[:address],
            category: atts[:category],
            dest_location_name: atts[:dest_location_name],
            photo_url_1: atts[:photo_url_1],
            photo_url_2: atts[:photo_url_2],
            photo_url_3: atts[:photo_url_3])
        else
          new_dest = Destination.create(
            name: atts[:name],
            description: atts[:description],
            address: atts[:address],
            category: atts[:category],
            dest_location_name: atts[:dest_location_name],
            photo_url_1: atts[:photo_url_1],
            photo_url_2: atts[:photo_url_2],
            photo_url_3: atts[:photo_url_3])
        end
        rating = Rating.find_or_create_by(stars: atts[:ratings_attributes]["0"
          ][:stars], note: atts[:ratings_attributes]["0"][:note], user_id: self.user.id)
        #add only if rating does not exist for destination
        self.trip_destination_rating_add(new_dest, rating)
        #add only if destination does not exist in trip
        self.trip_destinations_add(new_dest)
        trip_dest = TripDestination.find_by(trip_id: self.id, destination_id: new_dest.id)
        trip_dest.day = atts[:day]
        trip_dest.save
      end
  end

  def trip_destinations_add(dest_obj)
    find = self.destinations.find_by(name: dest_obj.name)
    unless find
      self.destinations << dest_obj
    end
  end

  def trip_destination_rating_add(dest_obj, rating_obj)
    find = dest_obj.ratings.find_by(user_id: self.user.id)
    if find
      find.update(stars: rating_obj.stars, note: rating_obj.note)
    else
      dest_obj.ratings << rating_obj
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
        trip.day_criteria_match?(search_params[:days]) && trip.location_criteria_match?(search_params[:location].capitalize)
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

  def total_votes
      if self.reviews.length != 0
        return self.reviews.inject(0) do |sum, review|
          sum + review.vote
        end
      else
        return 0
      end
  end

  def destinations_of_specific_day(day)
    destinations = self.destinations.select do |destination|
      destination.day(self) == day
    end
    while destinations.size < 3
      destination = Destination.new
      destination.ratings.build
      destinations.push(destination)
    end
    destinations
  end

  def self.sort_trips_by_votes(trips)
    trips.sort_by do |trip|
      trip.total_votes * -1
    end
  end


end
