# frozen_string_literal: true

require 'rails_helper'

describe 'visit Admin page', js: true do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  it 'visits manage calculators page' do
    visit '/admins/calculators/'
    expect(page).to have_content 'You are not authorized to access this page.'
  end

  it 'visits manage histories page' do
    visit '/admins/histories/'
    expect(page).to have_content 'You are not authorized to access this page.'
  end

  it 'visits manage users page' do
    visit '/admins/users/'
    expect(page).to have_content 'You are not authorized to access this page.'
  end
end
