require 'rails_helper'

RSpec.describe 'Admin Targets', type: :request do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:targets) { create_list(:target, 2) }
  before do
    sign_in admin_user
  end

  subject { get admin_targets_path }

  describe 'Display all the targets' do
    it 'Returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'Shows all the targets for the admin' do
      subject
      expect(response.body).to include(targets.first.title)
      expect(response.body).to include(targets.second.title)
    end
  end
end
