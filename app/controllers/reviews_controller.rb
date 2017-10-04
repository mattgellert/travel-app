class ReviewsController < ApplicationController
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
end
