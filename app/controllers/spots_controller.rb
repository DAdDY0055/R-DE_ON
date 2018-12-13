class SpotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]

  def index
    @spot = Spot.all
    @searched_spot = Spot.search(params[:spot][:spot_tag])
    # スポットの絞り込みがされていない場合、全てのスポットを対象に含める。
    binding.pry
    @searched_spot ||= @spot
    @hash = Gmaps4rails.build_markers(@searched_spot) do |spot, marker|
      binding.pry
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
    @spot.user_id = current_user.id
    require 'exifr/jpeg'
    if EXIFR::JPEG.new(@spot.spot_photo.file.file).exif?
      @spot.latitude = EXIFR::JPEG::new(@spot.spot_photo.file.file).gps.latitude
      @spot.longitude = EXIFR::JPEG::new(@spot.spot_photo.file.file).gps.longitude
    end
    if @spot.save
        redirect_to spots_path, notice: '登録しました！'
    else
      render 'new'
    end
  end

  def show
    @spot = Spot.find(params[:id])
    @tag  = Spot.find(params[:id]).spot_tag
    @favorite = current_user.favorites.find_by(spot_id: @spot.id)
    @comments = @spot.comments
    @comment  = @spot.comments.build
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

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    redirect_to spots_path, notice:"投稿を削除しました。"
  end

  def likes
    @spot = Spot.find(params[:id])
    @spot.like += 1
    @spot.save
    redirect_to spot_path(@spot.id), notice:"いいねしました！"
  end

  def search

  end

  private

  def spot_params
    params.require(:spot).permit(:spot_name, :address, :spot_photo, :spot_photo_cache, :spot_infomation, spot_tag:[])
  end

end
