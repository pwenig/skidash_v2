class MountainsController < ApplicationController

  include WeatherCondition

  def index
    @mountains = Mountain.all
    render json: @mountains
  end

  def forecast
    weather_results = {}
    zipcode = params['mountain']

    weather_results['forecast_response'] = WeatherCondition.get_weather('forecast', zipcode)
    weather_results['conditions_response'] = WeatherCondition.get_weather('conditions', zipcode)

    render json: weather_results
  end 

end
