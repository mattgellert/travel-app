class UsersController < ApplicationController
  before_action :logged_in
  skip_before_action :logged_in, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to trips_path #homefeed
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
  end

  def followees
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_photo_url, :password, :password_confirmation)
  end


end
