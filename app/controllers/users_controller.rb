class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = current_user
    @favorite_spot = @user.favorites_spots
    @user_spot = @user.spots
    gon.map_latitude  = 38.681583
    gon.map_longitude = 137.957183
    gon.map_zoon = 5
    # プロフィール上のマップにはお気に入り + 自分の投稿を表示するよう、@hashに追加
    @hash = Gmaps4rails.build_markers(@favorite_spot + @user_spot) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow render_to_string(partial: "spots/infowindow", locals: { spot: spot })
    end

    gon.map_hash = @hash # gon.map_hash = Gmaps4rails~ だと動かない。

  end
end
