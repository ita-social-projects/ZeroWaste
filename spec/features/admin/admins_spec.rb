# frozen_string_literal: true

require 'rails_helper'

describe 'Edit admin`s password page', js: true do
  let!(:admin){ create(:admin, email: 'test1@gmail.com', password: '12345admin') }
  
  it 'renders an edit page' do
    visit edit_admins_admin_path id: admin.id
    expect(page).to have_content 'Change your password'
    expect(page).to have_content 'New password'
    expect(page).to have_content 'Current password'
    expect(page).to have_content 'Confirm new password'
  end
end
