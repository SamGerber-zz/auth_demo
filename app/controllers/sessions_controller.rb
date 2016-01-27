class SessionsController < ApplicationController
  # Signs a user in
  def create
    @user = User.find_by_credentials(
      username: params[:user][:username],
      password: params[:user][:password]
    )

    if @user.blank?
      render :new
    else
      log_in!(@user)
      redirect_to user_url
    end
  end

  # Presents a login form
  def new
    render :new
  end

  # Signs a user out
  def destroy
    log_out!
    redirect_to new_session_url
  end
end
