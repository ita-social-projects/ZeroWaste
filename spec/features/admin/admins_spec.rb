# frozen_string_literal: true

require 'rails_helper'

describe 'Edit admin`s password page', js: true do
  let!(:admin){ create(:admin) }

  it 'renders an edit page' do
    visit edit_admins_admin_path id: admin.id
    expect(page).to have_content I18n.t 'admins.passwords.edit.change_password_header'
    expect(page).to have_content I18n.t 'admins.passwords.edit.form.new_password_label'
    expect(page).to have_content I18n.t 'admins.passwords.edit.form.current_password_label'
    expect(page).to have_content I18n.t 'admins.passwords.edit.form.confirm_password_label'
  end
end
