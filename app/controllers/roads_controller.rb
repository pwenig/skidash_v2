# Roads Controller
class RoadsController < ApplicationController
  include TrafficAlert

  def index
    @roads = Road.all
    render json: @roads
  end

  def alert
    render json: TrafficAlert.get_alerts(params['name'])
  end

  def images
    render json: TrafficAlert.get_images(params['name'])
  end

  def speeds
    render json: TrafficAlert.get_speeds(params['name'])
  end
end
