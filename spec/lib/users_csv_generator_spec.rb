# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersCsvGenerator, type: :lib do
  let(:time_login) { Time.new(2020, 0o1, 0o1).utc }
  let(:users) do
    [create(:user, email: "test@gmail.com", last_sign_in_at: time_login)]
  end

  it "export users" do
    expect(UsersCsvGenerator.call(users,
                                  fields: ["email", "last_sign_in_at"]))
      .to eq("email,last_sign_in_at\ntest@gmail.com,#{time_login}\n")
  end
end
