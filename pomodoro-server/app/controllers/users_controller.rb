class UsersController < ApplicationController
  # This is our new function that comes before Devise's one
  before_filter :authenticate_user_from_token!, except: [:create]

  def me
    render json: current_user
  end

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.create!(params[:user])
    render json: @user
  end

  def tomatoes
    @tomatoes = current_user.tomatoes
    render json: @tomatoes
  end
end
