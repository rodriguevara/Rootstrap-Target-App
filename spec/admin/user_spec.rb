require 'rails_helper'

RSpec.describe 'Admin Users', type: :request do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }

  before do
    sign_in admin_user
  end

  subject { get admin_users_path }

  describe 'Display all users' do
    it 'Returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'Shows all the users for the admin' do
      subject
      expect(response.body).to include(user1.email)
      expect(response.body).to include(user2.email)
    end
  end
end
