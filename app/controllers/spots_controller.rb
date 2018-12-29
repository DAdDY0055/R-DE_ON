class SpotsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :likes]

  def index
    # タグの絞り込み確認。絞り込みがある場合、対象のみインスタンス変数に格納。
    if params[:spot].present?
      @tag = params[:spot][:spot_tag].inspect
      @spot = Spot.tag_search(@tag)
    else
      # タグの絞り込みがない場合、全てのスポットをインスタンス変数に格納。
      @spot = Spot.all
    end
    @hash = Gmaps4rails.build_markers(@spot) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow render_to_string(partial: "spots/infowindow", locals: { spot: spot })
    end
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = current_user.spots.build(spot_params)
    # タグ情報を保存する際、"["と"]"を削除した状態で保存する(タグなしの場合、実行しない)
    @spot.spot_tag = @spot.spot_tag.delete("[").delete("]") if @spot.spot_tag

    require 'exifr/jpeg'
    if EXIFR::JPEG.new(@spot.spot_photo.file.file).exif?
      @spot.latitude = EXIFR::JPEG::new(@spot.spot_photo.file.file).gps.latitude
      @spot.longitude = EXIFR::JPEG::new(@spot.spot_photo.file.file).gps.longitude
    end
    if @spot.save
      redirect_to spots_path, notice: '登録しました！'
    else
      render :new
    end
  end

  def show
    @spot = Spot.find(params[:id])
    @tag  = Spot.find(params[:id]).spot_tag
    @favorite = current_user.favorites.find_by(spot_id: @spot.id) if current_user

    @comments = @spot.comments
    @comment  = @spot.comments.build
  end

  def edit
    @spot = Spot.find(params[:id])
    unless @spot.user_id == current_user.id
      redirect_to spot_path(@spot.id), notice: "自分の投稿以外は編集できません"
    end
  end

  def update
    @spot = Spot.find(params[:id])
    
    if @spot.update(spot_params)
      if @spot.spot_tag
        @spot.spot_tag = @spot.spot_tag.delete("[").delete("]")
        @spot.save
      end
      redirect_to spot_path(@spot.id), notice: "投稿を編集しました"
    else
      render :edit
    end
  end

  def destroy
    @spot = Spot.find(params[:id])
    unless @spot.user_id == current_user.id
      redirect_to spot_path(@spot.id), notice: "自分の投稿以外は削除できません"
    else
      @spot.destroy
      redirect_to spots_path, notice:"投稿を削除しました。"
    end
  end

  def likes
    @spot = Spot.find(params[:id])
    @spot.like += 1
    @spot.save
    redirect_to spot_path(@spot.id), notice:"いいねしました！"
  end

  private

  def spot_params
    params.require(:spot).permit(:spot_name, :address, :spot_photo, :spot_photo_cache, :spot_infomation, spot_tag:[])
  end

end
