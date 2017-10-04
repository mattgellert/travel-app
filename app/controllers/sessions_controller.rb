class SessionsController < ApplicationController
  before_action :logged_in
  skip_before_action :logged_in, only: [:new, :create]
  def new

  end

  def create
    @user = User.find_by(name: params[:name])
    if @user.try(:authenticate,params[:password])
      session[:user_id] = @user.id
      redirect_to trips_path #homefeed
    else
      render "new"
    end
  end

  def destroy
    session.delete :user_id
    redirect_to login_path
  end

end
