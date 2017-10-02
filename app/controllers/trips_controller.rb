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
    @trip.destinations.build
    @trip.destinations.build
    @trip.destinations.build
  end

  def create_destinations
    # byebug
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :days, :blurb, :intensity, :user_id, :start_date, :end_date,location_names: [])
  end

end
