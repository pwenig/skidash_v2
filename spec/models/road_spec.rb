require 'rails_helper'

describe Road do
  it 'creates a road' do
    road = Road.create(name: 'I-70')

    expect(road.name).to include('I-70')
  end
end
