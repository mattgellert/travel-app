class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in

  def current_user
    User.find_by_id(session[:user_id])
  end

  def logged_in
    unless !!current_user
      redirect_to login_path
    end
  end


end
