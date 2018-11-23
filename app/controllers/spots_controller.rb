class SpotsController < ApplicationController
  def index
  end

  def new
    @spot = Spot.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def spot_params
    params.require(:spot).permit(:spot_name, :address, :image, :image_cache, :spot_infomation)
  end

end
