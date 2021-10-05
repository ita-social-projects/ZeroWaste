require 'rspec'

describe 'Admins::UsersController' do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  context 'updating a user' do
    let(:user) { User.create! }
    it 'should let me update a user info' do
      put
      pending 'Not implemented'
    end
  end
end