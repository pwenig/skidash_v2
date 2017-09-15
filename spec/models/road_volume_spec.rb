require 'rails_helper'

RSpec.describe RoadVolume, type: :model do
  it 'creates a road volume record' do
    road_volume = RoadVolume.create(direction: 'east', volume: '100', time: 'Fri Sep 20 2017 11:40:31 AM')
    expect(road_volume.direction).to include('east')
  end 
end
