class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
