module WeatherCondition

  def self.get_weather(type, zipcode)

    response = HTTParty.get("http://api.wunderground.com/api/#{ENV['WEATHER_API']}/#{type}/q/#{zipcode}.json")

    if type == 'forecast'
      formatted_response = format_forecast(response)
    else
      formatted_response = format_conditions(response)
    end

    formatted_response

  end

  private

  def self.format_forecast(response)
    response['forecast']['txt_forecast']['forecastday'][0...4]
  end 

  def self.format_conditions(response)
    response['current_observation']
  end 

end 
