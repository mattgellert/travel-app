class TripsController < ApplicationController


  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
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
    # byebug
    @trips = Trip.trip_search_results(search_params, current_user)
    render "index"
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
    params.require(:trip).permit(:title, :days, :blurb, :intensity, :user_id, :start_date, :end_date,location_names: [], destinations_attributes: [:name, :description, :address, :category, :day, :dest_location_name, ratings_attributes:{}])
  end

  def search_params
    params.require(:search).permit(:location, :days, :qfriends)
  end

end
