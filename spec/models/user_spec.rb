require 'rails_helper'

describe User do
  it 'creates a user' do
    user = User.create(email: 'test@test.com', password: 'password')

    expect(user.email).to include('test@test.com')
  end
end
