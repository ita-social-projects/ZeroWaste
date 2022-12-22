# frozen_string_literal: true

require "rails_helper"

RSpec.describe Account::UsersController do
  context "inherited" do
    it { expect(described_class).to be < Account::BaseController }
  end
end
