require 'digest/sha2'

class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to user_url
    else
      #input didn't pass validation, re-render signup form
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    if current_user.blank?
      redirect_to new_session_url
    else
      @user = current_user
      render :show
    end
  end

  protected

  def user_params
    self.params.require(:user).permit(:username, :password)
  end

end
