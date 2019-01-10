class SpotsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :likes]

  def index
    #タグ検索や地図絞り込みがない場合、日本全体で全スポット表示
    if params[:spot].nil?
      @spot = Spot.all
      gon.map_latitude  = 38.681583
      gon.map_longitude = 137.957183
      gon.map_zoon = 5
    else
      # タグの絞り込みがある場合、対象のみインスタンス変数に格納。
      if params[:spot][:spot_tag].nil? || params[:spot][:spot_tag] == "全表示"
        @spot = Spot.all
      else
        @tag = params[:spot][:spot_tag].inspect
        @spot = Spot.tag_search(@tag)
      end
      # 地図の絞り込みがある場合、指定地点を中心に表示
      if params[:spot][:map_narrowing_down] == ""
        gon.map_latitude  = 38.681583
        gon.map_longitude = 137.957183
        gon.map_zoon = 5
      else
        @map_narrowing_down_location = params[:spot][:map_narrowing_down]
        gon.map = Geocoder.search(@map_narrowing_down_location)
        gon.map_latitude  = gon.map.first.latitude
        gon.map_longitude = gon.map.first.longitude
        gon.map_zoon = 12
      end
    end

    @hash = Gmaps4rails.build_markers(@spot) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow render_to_string(partial: "spots/infowindow", locals: { spot: spot })
    end

    gon.map_hash = @hash # gon.map_hash = Gmaps4rails~ だと動かない。

end

  def new
    @spot = Spot.new
  end

  def create
    @spot = current_user.spots.build(spot_params)
    # タグ情報を保存する際、"["と"]"を削除した状態で保存する(タグなしの場合、実行しない)
    @spot.spot_tag = @spot.spot_tag.delete("[").delete("]") if @spot.spot_tag

    require 'exifr/jpeg'
    if @spot.spot_photo.file
      if EXIFR::JPEG::new(@spot.spot_photo.file.file).gps
        @spot.latitude = EXIFR::JPEG::new(@spot.spot_photo.file.file).gps.latitude
        @spot.longitude = EXIFR::JPEG::new(@spot.spot_photo.file.file).gps.longitude
      end
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

    gon.map_latitude  = @spot.latitude
    gon.map_longitude = @spot.longitude
    gon.spot_address  = @spot.address
    gon.map_zoon = 12

    @hash = Gmaps4rails.build_markers(@spot) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow render_to_string(partial: "spots/infowindow", locals: { spot: spot })
    end

    gon.map_hash = @hash # gon.map_hash = Gmaps4rails~ だと動かない。
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
    params.require(:spot).permit(:spot_name, :address, :spot_photo, :spot_photo_cache, :spot_infomation, spot_tag:[], map_narrowing_down:[])
  end

end
