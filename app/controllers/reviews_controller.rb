class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @trip = Trip.find(params[:trip_id])
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @review = Review.new(user_id: current_user.id, trip_id: @trip.id, comment: params[:review][:comment], vote: params[:review][:vote])
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

  private

  def review_params
    params.require(:review).permit(:comment, :vote)
  end
end
