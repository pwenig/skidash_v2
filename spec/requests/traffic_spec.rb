require 'spec_helper'
require 'rails_helper'

describe 'Traffic API' do 

  let(:road) {'I-70'}

  it 'gets traffic alert message' do 
    VCR.use_cassette('alert_messages', :record => :new_episodes) do 
     @alerts = TrafficAlert.get_alerts(road) 
    end 

    expect(@alerts.present?).to be(true)
    expect(@alerts[0]['RoadName']).to include(road)
  end 

  it 'gets traffic images' do 
    VCR.use_cassette('traffic_images', :record => :new_episodes) do 
      @images = TrafficAlert.get_images(road)
    end 

    expect(@images.present?).to be(true)
    expect(@images.length > 0).to be(true)
  end 

  it 'gets traffic speeds' do 
    VCR.use_cassette('traffic_speeds', :record => :new_episodes) do 
      @speeds = TrafficAlert.get_speeds(road)
    end 
    expect(@speeds.present?).to be(true)
    expect(@speeds[0]['RoadName']).to include(road)
  end 

end 