class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(name: params[:name])
    if @user.authenticate(params[:password])
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
