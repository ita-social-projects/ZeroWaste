# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersCsvGenerator do
  let(:time_login) { Time.new(2020, 0o1, 0o1).utc }

  let(:users) do
    [create(:user, email: "test@gmail.com", first_name: "Han", last_name: "Solo", last_sign_in_at: time_login)]
  end

  let(:csv_content) do
    result = "email,first_name,last_name,last_sign_in_at\n"

    users.each do |user|
      result += "#{users.first.email},#{users.first.first_name},#{users.first.last_name},#{time_login}\n"
    end

    result
  end

  it "export users" do
    expect(UsersCsvGenerator.call(users,
                                  fields: ["email", "first_name", "last_name", "last_sign_in_at"]))
      .to eq(csv_content)
  end
end
