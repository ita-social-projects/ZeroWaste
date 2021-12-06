# frozen_string_literal: true

require 'rails_helper'

describe 'visit admin page', js: true do
  let(:time_login) { Time.new(2020, 0o1, 0o1).utc }
  let!(:user1) do
    create(:user, email: 'test1@gmail.com', password: '12345878',
                  last_sign_in_at: time_login)
  end

  it 'visits admin page' do
    visit '/admins/users'
    expect(page).to have_content 'test1@gmail.com'
    expect(page).to have_content time_login
  end

  context 'when user clicks show icon' do
    it 'redirects to user info page' do
      visit '/admins/users'
      within(:css, "#user-info-#{user1.id}") do
        click_link(href: "/admins/users/#{user1.id}")
      end
      expect(page).to have_current_path('/admins/users/1')
      expect(page).to have_content 'Email'
      expect(page).to have_content 'First name'
      expect(page).to have_content 'Last name'
      expect(page).to have_content 'Country'
      expect(page).to have_content 'Last sign in date and time'
      expect(page).to have_content 'Current sign in IP'
      expect(page).to have_content 'Last sign in IP'
    end
  end

 context 'when user clicks edit icon' do
   it 'redirects to user edit info page' do
     visit '/admins/users'
     within(:css, "#user-info-#{user1.id}") do
       click_link(href: "/admins/users/#{user1.id}/edit")
     end
     expect(page).to have_current_path('/admins/users/1/edit')
     expect(page).to have_content 'First name'
     expect(page).to have_content 'Last name'
     expect(page).to have_content 'Country'
   end
 end

 context 'when edit user`s info correctly' do
   it 'redirects to user info page' do
     visit '/admins/users/1/edit'
     find('#user_first_name').set('John')
     find('#user_last_name').set('Doe')
     find('#user_country').set('UK')
     click_button 'Update User'
     expect(page).to have_current_path('/admins/users/1')
     expect(page).to have_content 'John'
     expect(page).to have_content 'Doe'
     expect(page).to have_content 'UK'
   end
 end

 context 'when edit user`s info wrongly' do
  it 'show error messages' do
    visit '/admins/users/1/edit'
    find('#user_first_name').set('J')
    find('#user_last_name').set('D')
    click_button 'Update User'
    expect(page).to have_content 'First name is too short (minimum is 2 characters)'
    expect(page).to have_content 'Last name is too short (minimum is 2 characters)'
  end
 end
end

describe 'user info page' do
  context 'viewing non-existing user' do
    it 'renders the 404 page' do
      visit '/admins/users/1939'
      expect(page).to have_content('page you were looking for doesn\'t exist')
    end
  end
end
