require 'rails_helper'

describe 'Traffic API' do
  let(:road) { 'I-70' }

  it 'gets traffic alert message' do
    VCR.use_cassette('alert_messages', record: :new_episodes) do
      @alerts = TrafficAlertService.get_alerts(road)
    end

    expect(@alerts.present?).to be(true)
    expect(@alerts[0]['RoadName']).to include(road)
  end

  it 'gets traffic images' do
    VCR.use_cassette('traffic_images', record: :new_episodes) do
      @images = TrafficAlertService.get_images(road)
    end

    expect(@images.present?).to be(true)
    expect(!@images.empty?).to be(true)
  end

  it 'gets traffic speeds' do
    VCR.use_cassette('traffic_speeds', record: :new_episodes) do
      @speeds = TrafficAlertService.get_speeds(road)
    end
    expect(@speeds.present?).to be(true)
    expect(@speeds[0]['RoadName']).to include(road)
  end

  it 'gets road volume' do
    VCR.use_cassette('traffic_volume', record: :new_episodes) do
      @volume = TrafficVolumeService.get_road_volume('West')
    end
    expect(@volume.present?).to be(true)
  end
end
