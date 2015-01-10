class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :find_current_user

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def verify_user
    if current_user.nil?
      flash[:error] = "You must be logged in to view this page"
      redirect_to "/login"
    end
  end

  def find_current_user
    @current_user = current_user
  end

end
