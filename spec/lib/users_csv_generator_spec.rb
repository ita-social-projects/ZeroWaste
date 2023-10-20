# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersCsvGenerator do
  let(:time_login) { Time.new(2020, 0o1, 0o1).utc }
  let(:users) do
    [create(:user, email: "test@gmail.com", first_name: "Han", last_name: "Solo", last_sign_in_at: time_login)]
  end

  it "export users" do
    expect(UsersCsvGenerator.call(users,
                                  fields: ["email", "first_name", "last_name", "last_sign_in_at"]))
      .to eq("email,first_name,last_name,last_sign_in_at\n#{user.email},#{user.first_name},#{user.last_name},#{time_login}\n")
  end
end
