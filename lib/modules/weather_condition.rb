# Module for the Weather API
module WeatherCondition
  class << self
    def get_weather(type, zipcode)
      response = HTTParty.get("#{ENV['WEATHER_URL']}/#{type}/q/#{zipcode}.json")
      if type == 'forecast'
        format_forecast(response)
      else
        format_conditions(response)
      end
      formatted_response
    end

    private

    def format_forecast(response)
      response['forecast']['txt_forecast']['forecastday'][0...4]
    end

    def format_conditions(response)
      response['current_observation']
    end
  end
end
