class DestinationsController < ApplicationController

  def show
    @destination = Destination.find(params[:id])
  end

  def index
    @destinations = Destination.destination_sort_by_rating(Destination.all)
  end

  def search
    @destinations = Destination.dest_search_results(search_params)
    render "index"
  end

  private

  def search_params
    params.require(:search).permit(:qname, :qlocation, :qcategory)
  end
end
