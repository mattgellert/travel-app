class TripsController < ApplicationController

  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.create(trip_params)
    # byebug
    redirect_to new_destinations_path(@trip)
  end

  def new_destinations
    @trip = Trip.find(params[:id])
    destination1 = @trip.destinations.build
    destination2 = @trip.destinations.build
    destination3 = @trip.destinations.build
    destination1.ratings.build
    destination2.ratings.build
    destination3.ratings.build
  end

# params = { "trip"=>{"destinations_attributes"=>
#   {"0"=>{"name"=>"Great Barrier Reef", "description"=>"Snorkeling at great barrier reef", "address"=>"balh", "category"=>"attraction", "ratings"=>{"stars"=>"3", "note"=>"what what"}, "day"=>"1"}, "1"=>{"name"=>"Food", "description"=>"yum", "address"=>"blah", "category"=>"restaurant", "ratings"=>{"stars"=>"3", "note"=>"yummy"}, "day"=>"1"}, "2"=>{"name"=>"", "description"=>"", "address"=>"", "category"=>"restaurant", "ratings"=>{"stars"=>"3", "note"=>""}, "day"=>"1"}, "3"=>{"name"=>"testint", "description"=>"g", "address"=>"g", "category"=>"restaurant", "ratings"=>{"stars"=>"3", "note"=>"g"}, "day"=>"2"}, "4"=>{"name"=>"", "description"=>"", "address"=>"", "category"=>"restaurant", "ratings"=>{"stars"=>"3", "note"=>""}, "day"=>"2"}}}}

  def create_destinations
    # byebug
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)
    redirect_to trip_path(@trip)
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
  end

  def show
    @trip = Trip.find(params[:id])
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :days, :blurb, :intensity, :user_id, :start_date, :end_date,location_names: [], destinations_attributes: [:name, :description, :address, :category, :day, ratings_attributes:{}])
  end

end
