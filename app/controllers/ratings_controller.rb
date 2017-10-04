class RatingsController < ApplicationController
  def new
    @destination = Destination.find(params[:destination_id])
    @rating = Rating.new
  end

  def create
    @destination = Destination.find(params[:destination_id])
    @rating = @destination.ratings.build(note: params[:rating][:note], stars: params[:rating][:stars], user_id: current_user.id)
    if @rating.save
      redirect_to destination_path(@destination)
    else
      render "new"
    end
  end
  
  def index
    @destination = Destination.find(params[:destination_id])
    redirect_to destination_path(@destination)
  end
end
