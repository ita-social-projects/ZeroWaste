# # frozen_string_literal: true

require "rails_helper"

RSpec.describe Account::UsersHelper, type: :helper do
  let!(:user) { create(:user) }

  describe ".toggle_block_param" do
    it "toggles the 'blocked' attribute" do
      user.update(blocked: true)

      expect(helper.toggle_block_param(user)).to eq({ blocked: false })
    end
  end

  describe ".toggle_confirm" do
    it "returns '.confirm_unblock' if the user is blocked" do
      user.update(blocked: true)
      allow(helper).to receive(:t).with(".confirm_unblock").and_return(".confirm_unblock")

      expect(helper.toggle_confirm(user)).to eq(".confirm_unblock")
    end

    it "returns '.confirm_block' if the user is unblocked" do
      user.update(blocked: false)
      allow(helper).to receive(:t).with(".confirm_block").and_return(".confirm_block")

      expect(helper.toggle_confirm(user)).to eq(".confirm_block")
    end
  end

  describe ".toggle_class" do
    it "returns 'lock' if the user is blocked" do
      user.update(blocked: true)

      expect(helper.toggle_class(user)).to eq("lock")
    end

    it "returns 'lock-open' if the user is not blocked" do
      user.update(blocked: false)

      expect(helper.toggle_class(user)).to eq("lock-open")
    end
  end
end
