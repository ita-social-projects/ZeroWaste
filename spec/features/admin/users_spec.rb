require 'rails_helper'

describe 'visit admin page', js: true do
  let(:time_login) { Time.new(2020,01,01).utc }
  let!(:user1) { create(:user, email: 'test1@gmail.com', password: '12345878', last_sign_in_at: time_login) }

  it 'visits admin page' do
      visit '/admins/users'
      expect(page).to have_content 'test1@gmail.com'
      expect(page).to have_content time_login
  end
end
