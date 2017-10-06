class TripsController < ApplicationController
  before_action :logged_in

  def index
    @trips = Trip.sort_trips_by_votes(Trip.all)
  end

  def new
    @trip = Trip.new
    location1 = @trip.locations.build
    location2 = @trip.locations.build
    location3 = @trip.locations.build
  end

  def create
    @trip = Trip.create(trip_params)
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

  def create_destinations
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)
    redirect_to trip_path(@trip)
  end

  def search
    @trips = Trip.trip_search_results(search_params, current_user)
    render "index"
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)
    redirect_to edit_destinations_path(@trip)
  end

  def edit_destinations
    @trip = Trip.find(params[:id])
    # byebug
    #what to do here
  end

  def update_destinations
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)
    redirect_to trip_path(@trip)
  end

  def show
    @trip = Trip.find(params[:id])
    @destinations = @trip.destinations.sample(5)
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :days, :blurb, :intensity, :user_id, :start_date, :end_date,location_names: [], destinations_attributes: [:id, :name, :description, :address, :category, :day, :dest_location_name, :photo_url_1,  :photo_url_2,  :photo_url_3, ratings_attributes:{}])
  end

  def search_params
    params.require(:search).permit(:location, :days, :qfriends)
  end

end
