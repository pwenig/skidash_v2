require 'spec_helper'
require 'rails_helper'

describe 'Weather API' do
  it 'gets weather forecasts for four periods' do
    VCR.use_cassette('weather_forecast', record: :new_episodes) do
      @weather_forecast = WeatherConditionService.get_weather('forecast', '80304')
    end

    expect(@weather_forecast.present?).to be(true)
    expect(@weather_forecast.length).to be(4)
  end

  it 'gets weather conditions' do
    VCR.use_cassette('weather_conditions', record: :new_episodes) do
      @weather_conditions = WeatherConditionService.get_weather('conditions', '80304')
    end
    expect(@weather_conditions.present?).to be(true)
    expect(@weather_conditions['display_location']['full']).to include('Boulder, CO')
  end

  it 'tests format_forecast method' do
    VCR.use_cassette('weather_response', record: :new_episodes) do
      @response = HTTParty.get("#{ENV['WEATHER_URL']}/forecast/q/80304.json")
    end
    formatted = WeatherConditionService.format_forecast(@response)
    expect(formatted.length).to be(4)
  end

  it 'tests format_conditions method' do
    VCR.use_cassette('weather_response_conditions', record: :new_episodes) do
      @response = HTTParty.get("#{ENV['WEATHER_URL']}/conditions/q/80304.json")
    end
    formatted = WeatherConditionService.format_conditions(@response)
    expect(formatted['display_location']['full']).to include('Boulder, CO')
  end
end
