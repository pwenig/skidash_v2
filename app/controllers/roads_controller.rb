class RoadsController < ApplicationController

  def index
    @roads = Road.all
    render json: @roads
  end

end 