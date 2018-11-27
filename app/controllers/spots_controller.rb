class SpotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]

  def index
    @spot = Spot.all
    @hash = Gmaps4rails.build_markers(@spot) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow spot.spot_name
    end
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    require 'exifr/jpeg'
    binding.pry
    if EXIFR::JPEG.new(@spot.spot_photo.file.file).exif?
      @spot.latitude = EXIFR::JPEG::new(@spot.spot_photo.file.file).gps.latitude
      @spot.longitude = EXIFR::JPEG::new(@spot.spot_photo.file.file).gps.longitude
    end
      if @spot.save
        binding.pry
        redirect_to spots_path, notice: '登録しました！'
    else
      render 'new'
    end
  end

  def show
    @spot = Spot.last
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    if @spot.update(spot_params)
      redirect_to spot_path(@spot.id), notice: "投稿を編集しました"
    else
      render 'edit'
    end
  end

  def spot_params
    params.require(:spot).permit(:spot_name, :address, :spot_photo, :spot_photo_cache, :spot_infomation)
  end

end
