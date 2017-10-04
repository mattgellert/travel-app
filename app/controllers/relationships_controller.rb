class RelationshipsController < ApplicationController
  before_action :logged_in

  def create
    Relationship.create(followee_id: params[:id], follower_id: current_user.id)
    # byebug
    redirect_to user_path(User.find(params[:id]))
  end

  def destroy
    relationship = Relationship.find_by(followee_id: params[:id], follower_id: current_user.id)
    relationship.destroy
    redirect_to user_path(User.find(params[:id]))
  end
end
