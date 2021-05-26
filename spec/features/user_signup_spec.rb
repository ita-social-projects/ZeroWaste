require 'rails_helper'

describe 'visit user sign-up page', js:true do 
  let(:user) { create(:user) }
  context 'when sign-up with correct data' do
    it 'redirect to calculators page' do
      visit '/users/sign_up'
      fill_in 'email' with user.email
      fill_in 'password' with user.password
      fill_in 'first_name' with user.first_name
      fill_in 'last_name' with user.last_name
      fill_in 'country' with user.country
      click_button 'Sign up' 
      
    end
  end
end
