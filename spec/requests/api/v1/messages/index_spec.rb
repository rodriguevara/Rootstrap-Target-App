require 'rails_helper'

describe 'GET /api/v1/conversations/:conversation_id/messages', type: :request do
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation_with_users_messages, user1: user) }

  context 'when the request is valid' do
    subject do
      get "/api/v1/conversations/#{conversation.id}/messages", headers: auth_headers, as: :json
    end

    it 'returns all the conversation messages' do
      subject
      expect(json).not_to be_empty
      expect(json['messages'].size).to eq(conversation.messages.size)
      expect(json['messages'].pluck('id'))
        .to match_array(conversation.messages.pluck(:id))
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end
  end
end
