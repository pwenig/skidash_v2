# Roads Controller
class RoadsController < ApplicationController

  def index
    @roads = Road.all
    render json: @roads
  end

  def alert
    render json: TrafficAlertService.get_alerts(params['name'])
  end

  def images
    render json: TrafficAlertService.get_images(params['name'])
  end

  def speeds
    render json: TrafficAlertService.get_speeds(params['name'])
  end
end
