class RelationshipsController < ApplicationController

  def create
    Relationship.create(followee_id: params[:id], follower_id: session[:user_id])
    redirect_to user_path(User.find(params[:id]))
  end

  def destroy
    relationship = Relationship.find_by(followee_id: params[:id], follower_id: session[:user_id])
    relationship.destroy
    redirect_to user_path(User.find(params[:id]))
  end
end
