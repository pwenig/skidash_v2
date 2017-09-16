# Dashboard Controller
class DashboardController < ApplicationController
  before_action :get_road_volume, only: [:index]
  def index
  end 

  # Need instance var for graphing erb
  def get_road_volume
    @volumes_east = RoadVolume.get_road_volume('East')
    @volumes_west = RoadVolume.get_road_volume('West')
  end 
end
