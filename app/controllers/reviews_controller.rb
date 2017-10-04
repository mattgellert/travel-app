class ReviewsController < ApplicationController
  before_action :logged_in

  def new
    @trip = Trip.find(params[:trip_id])
    @review = Review.new
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @review = @trip.reviews.build(comment: params[:review][:comment], vote: params[:review][:vote], user_id: current_user.id)
    if @review.save
      redirect_to trip_path(@trip)
    else
      render "new"
    end
  end

  def index
    @trip = Trip.find(params[:trip_id])
    redirect_to trip_path(@trip)
  end

  def show
    @trip = Trip.find(params[:trip_id])
    @review = Review.find(params[:id])
  end

  def edit
    @trip = Trip.find(params[:trip_id])
    @review = Review.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:trip_id])
    @review = Review.find(params[:id])
    if @review.update(comment: params[:review][:comment], vote: params[:review][:vote], user_id: current_user.id)
      redirect_to trip_path(@trip)
    else
      render "edit"
    end
  end
end
