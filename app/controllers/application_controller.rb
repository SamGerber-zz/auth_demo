class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception


  # Fetches the user we are logged in as
  def current_user
    return nil if session[:session_token].nil?
    User.find_by(session_token: session[:session_token])
  end

  # Log a user out
  def log_in!(user)
    # force other clients to log out by regenerating the token
    user.reset_session_token!
    # log this client in
    session[:session_token] = user.session_token
  end

  # Log a user out
  def log_out!
    session[:session_token] = nil
  end
end
