module WeatherCondition
  def self.get_weather(type, zipcode)
    response = HTTParty.get("#{ENV['WEATHER_URL']}/#{type}/q/#{zipcode}.json")

    formatted_response = if type == 'forecast'
                           format_forecast(response)
                         else
                           format_conditions(response)
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
