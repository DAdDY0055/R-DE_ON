class SpotsController < ApplicationController
  def index
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    binding.pry
    require 'exifr/jpeg'
    @spot.latitude = EXIFR::JPEG::new(@spot.spot_photo.file.file).gps.latitude
    @spot.longitude = EXIFR::JPEG::new(@spot.spot_photo.file.file).gps.longitude
    if @spot.save
      # redirect_to spot_path, notice: '登録しました！'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def spot_params
    params.require(:spot).permit(:spot_name, :address, :spot_photo, :spot_photo_cache, :spot_infomation)
  end

end
