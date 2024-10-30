# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersCsvGenerator do
  let(:time_login) { Time.new(2020, 0o1, 0o1).in_time_zone("Europe/Kyiv") }

  let(:users) do
    [create(:user, email: "test@gmail.com", first_name: "Han", last_name: "Solo", last_sign_in_at: time_login)]
  end

  let(:csv_content) do
    "email,first_name,last_name,last_sign_in_at\n" +
      users.map { |user| "#{user.email},#{user.first_name},#{user.last_name},#{user.last_sign_in_at}\n" }.join
  end

  it "export users" do
    expect(UsersCsvGenerator.call(users,
                                  fields: ["email", "first_name", "last_name", "last_sign_in_at"]))
      .to eq(csv_content)
  end
end
