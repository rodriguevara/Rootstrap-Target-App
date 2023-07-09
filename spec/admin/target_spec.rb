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

  describe 'Filter targets' do
    it 'shows only the filtered targets by topic' do
      topic1 = FactoryBot.create(:topic)
      topic2 = FactoryBot.create(:topic)

      target1 = FactoryBot.create(:target, title: 'target1', topic: topic1)
      target2 = FactoryBot.create(:target, title: 'target2', topic: topic2)

      get '/admin/targets', params: { q: { topic_id_eq: target1.topic_id } }
      expect(response).to be_successful
      expect(response.body).to include(target1.title)
      expect(response.body).not_to include(target2.title)
    end
  end
end
