class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception


  # Fetches the user we are logged in as
  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  # Log a user out
  def log_in!(user)
    session[:user_id] = user.id
  end

  # Log a user out
  def log_out!
    session[:user_id] = nil
  end
end
