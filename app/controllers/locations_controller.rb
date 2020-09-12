class LocationsController < ApplicationController
  before_action :set_location, except: [:create, :index]
  def create
    @location = Location.new(location_params.except(:address))
    address = Address.new(location_params[:address])
    @location.address = address
    @location.user = current_user
    if @location.save
      render :show, status: :created
    else
      render json: {errors: @location.errors }, status: :unprocessable_entity
    end
  end

  def index
    @locations = Location.all
    apply_scopes
  end

  def show
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def apply_scopes
    @locations = @locations.search(params[:q]) if params[:q].present?
    @locations = @locations.order_as_map(params[:map], current_user.latitude, current_user.longitude)
    @locations = @locations.offset(params[:offset]) if params[:offset].present?
    @locations = @locations.limit(params[:limit] || 10)
  end

  def location_params
    params.require(:location).permit(:name, :description, address: [:addressable_id, :addressable_type, :street, :suburb, :city, :state, :country, :latitude, :longitude])
  end
end
