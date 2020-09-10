class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, except: [:create]
  def create
    @user = User.new(user_params)
    if @user.save
      render :show, status: :created
    else
        render json: {errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @user.update(user_params)
        render :show, status: :ok
    else
        render json: {errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
