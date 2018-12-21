class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = current_user
    @favorite_spot = @user.favorites_spots
    @user_spot = @user.spots
    # プロフィール上のマップにはお気に入り + 自分の投稿を表示するよう、@hashに追加
    @hash = Gmaps4rails.build_markers(@favorite_spot + @user_spot) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow render_to_string(partial: "spots/infowindow", locals: { spot: spot })
    end
  end
end
