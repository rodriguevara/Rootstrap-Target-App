require 'rails_helper'

describe 'GET /api/v1/conversations/:conversation_id/messages', type: :request do
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation_with_users_messages, user1: user) }

  context 'when the request is valid' do
    subject do
      get "/api/v1/conversations/#{conversation.id}/messages", headers: auth_headers, as: :json
    end

    it 'returns the correct messages in descending order' do
      subject
      expect(json).not_to be_empty
      expect(json['messages'].pluck('id'))
        .to match_array(conversation.messages.last(10).pluck(:id))
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'returns the correct amount of messages per page' do
      subject
      expect(json['messages'].size).to eq(ENV.fetch('MAX_MESSAGES').to_i)
    end
  end
end
