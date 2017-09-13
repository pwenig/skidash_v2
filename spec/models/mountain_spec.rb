require 'rails_helper'

describe Mountain do
  it 'creates a mountain' do
    mountain = Mountain.create(name: 'Eldora')

    expect(mountain.name).to include('Eldora')
  end
end
