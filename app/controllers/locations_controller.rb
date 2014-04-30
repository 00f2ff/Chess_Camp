class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  # check authorization
  authorize_resource
  
  def index
    @activeLocations = Location.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactiveLocations = Location.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @activeCamps = @location.camps.active.chronological
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to @location, notice: "The location #{@location.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @location.update(location_params)
      redirect_to @location, notice: "The location #{@location.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_url, notice: "The location #{@location.name} was removed from the system."
  end

  private
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      # don't allow latitude and longitude
      params.require(:location).permit(:name, :street_1, :street_2, :city, :state, :zip, :max_capacity, :active)
    end
end
