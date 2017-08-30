class MountainsController < ApplicationController

  require 'httparty'

  def index
    @mountains = Mountain.all
    render json: @mountains
  end

  def forecast
    zipcode = params['mountain']
    response = HTTParty.get("http://api.wunderground.com/api/#{ENV['WEATHER_API']}/forecast/q/#{zipcode}.json")
    render json: response['forecast']['txt_forecast']
  end 
  
end
