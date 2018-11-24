class SpotsController < ApplicationController
  def index
    @spot = Spot.all
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
      # redirect_to spot_path, notice: '登録しました！'　　→ 詳細画面を作成した後コメントアウト解除する
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
