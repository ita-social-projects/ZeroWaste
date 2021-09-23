require 'rails_helper'


RSpec.describe UsersCsvGenerator ,js: true do
  let(:time_login) { Time.new(2020, 0o1, 0o1).utc }
  let!(:users) { [create(:user, email: 'test@gmail.com', last_sign_in_at: time_login)] }

  context '' do
    it 'test' do
      expect(UsersCsvGenerator.call(users,
                                    fields: %w[email last_sign_in_at])).to eq("email,last_sign_in_at\ntest@gmail.com,#{time_login}\n")
    end
  end
end
