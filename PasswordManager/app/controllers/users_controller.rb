require 'digest/md5'

class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    new_user = User.new(user_params)
    new_user.password_hash = Digest::MD5.hexdigest(new_user.password).to_s
    new_user.save
  end

  def show
    verify_user
    @user = current_user
  end

  def login
    @user = User.new
  end

  def logout
    session[:user_id] = nil
    redirect_to action: "login"
  end

  def authenticate
    user_requested = User.find_by_username(params[:user][:username])
    if Digest::MD5.hexdigest(params[:user][:password]) == user_requested.password_hash
      session[:user_id] = user_requested.id
      redirect_to action: "show", id: user_requested.id
    else
      render "login"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password2)
  end
end
