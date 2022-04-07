require 'rails_helper'

describe 'POST /receive_notifications' do
  it 'takes user with false receive_recomendations' do
    user = FactoryBot.create(:user)
    expect(user.receive_recomendations).to eq false 
    end
end
