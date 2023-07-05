require 'rails_helper'

describe 'GET /api/v1/conversations', type: :request do
  let(:user)   { create(:user) }
  let(:user2)  { create(:user) }
  let(:topic)  { create(:topic) }
  # before(:each) do
  #   target = create(:target, user_id: user.id)
  #   create_list(
  #     :target, 2,
  #     topic_id: target.topic.id,
  #     user_id: user2.id,
  #     lat: target.lat,
  #     lon: target.lon
  #   )
  # end
  let(:target1) { create(:target, user_id: user.id, topic_id: topic.id, radius: 1, lat: 5, lon: 6) }
  let(:target) { create(:target, user_id: user2.id, topic_id: topic.id, radius: 1, lat: 5, lon: 6) }

  let!(:conversation) { create(:conversation, topic_id: topic.id) }
  let!(:conversations_user1) { create(:conversations_user, user: user, conversation: conversation) }
  let!(:conversations_user2) { create(:conversations_user, user: user2, conversation: conversation) }

  context 'when the request is valid' do
    subject { get api_v1_conversations_path, headers: auth_headers, as: :json }

    it 'returns the conversations in the correct format' do
      subject
      expect(json['conversations'].first['matched_user']['username']).to eq(user2.username)
      expect(json['conversations'].first['matched_user']['first_name']).to eq(user2.first_name)
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end
  end
end
