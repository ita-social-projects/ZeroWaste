# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  describe "GET #set_i18n_locale_from_params" do
    context "when an invalid locale is provided" do
      it "sets a flash notice about the unavailable translation" do
        get :redirection, params: { locale: "invalid_locale" }

        expect(flash.now[:notice]).to eq("invalid_locale translation not available")
      end
    end

    context "when a valid locale is provided" do
      it "does not set a flash notice" do
        get :redirection, params: { locale: "en" }

        expect(flash.now[:notice]).to be_nil
      end
    end
  end
end
