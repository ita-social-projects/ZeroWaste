# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminsController', type: :request do
  let!(:admin){ create(:admin, email: 'test1@gmail.com', password: '12345admin') }

  context "when new password is valid" do
    it "changes password" do 
      get admins_admin_edit_path admin_id: admin.id
      expect(response).to have_http_status(200)

      post admins_admin_update_path, 
      :params => { :admin => {:current_password => "12345admin", 
                              :password => "123admin", 
                              :password_confirmation => "123admin"} }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(admins_users_path)

    end
  end

  context "when new password is not valid" do
    it "renders form" do 
      get admins_admin_edit_path admin_id: admin.id
      expect(response).to have_http_status(200)

      post admins_admin_update_path, 
      :params => { :admin => {:current_password => "12345admin", 
                              :password => "123", 
                              :password_confirmation => "123"} }
      expect(response).to have_http_status(200)
    end
  end
end
