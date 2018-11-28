class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @spot = Spot.all
    @hash = Gmaps4rails.build_markers(@spot) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow spot.spot_name
    end
  end
end
