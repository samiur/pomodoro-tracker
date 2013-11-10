class TomatoesController < ApplicationController
  before_filter :find_user

  def index
    @tomatoes = @user.tomatoes
    render json: @tomatoes
  end

  def create
    @tomato = Tomato.create!(params.require(:tomato).permit(:plan_time, :break_time, :work_time, :plan_time_finished, :break_time_finished, :work_time_finished, tasks_attributes: [:name, :completed]))
    @user.tomatoes << @tomato
    render json: @tomato
  end

  def show
    @tomato = @user.tomatoes.where(id: params[:id]).first
    if @tomato
      render json: @tomato
    else
      render json: {errors: ["Unknown tomato id"]}, success: false, status: :unauthorized
    end
  end

  private

  def find_user
    @user = User.where(id: params[:user_id]).first
    unless @user
      render json: {errors: ["Unknown user id"]}, success: false, status: :unauthorized
    end
  end
end
