class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, except: [:create]
  def create
    @user = User.new(user_params)
    address = Address.new(user_params[:address])
    @user.address = address
    if @user.address = Address.upsert(address_params) && @user.save
      render :show, status: :created
    else
        render json: {errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    address = Address.find_or_initialize_by(addressable_id: @user.id, addressable_type: "User")
    address.assign_attributes(user_params[:address])
    @user.address = address
    if @user.update(user_params.except(:address))
      render :show, status: :ok
    else
      byebug
      render json: {errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, address: [:addressable_id, :addressable_type, :street, :suburb, :city, :state, :country, :latitude, :longitude])
  end
end
