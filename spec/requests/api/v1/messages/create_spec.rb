require 'rails_helper'

describe 'POST /api/v1/conversations/:conversation_id/messages', type: :request do
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation_with_users_messages, user1: user) }
  let(:message) do
    create(:message, body: 'TEST', conversation_id: conversation.id, user_id: user.id)
  end
  subject do
    post "/api/v1/conversations/#{conversation.id}/messages",
         params: { user_id: user.id, body: 'TEST', conversation_id: conversation.id },
         headers: auth_headers, as: :json
  end

  context 'when the request is valid' do
    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'creates the message' do
      expect { subject }.to change(Message, :count)
    end

    it 'returns the message in the correct format' do
      subject
      expect(json[:message][:body]).to eq(message.body)
      expect(json[:message][:sender]).to eq(User.find_by(id: message.user_id).username)
    end
  end

  context 'when the user does not belong to the conversation' do
    let(:other_user) { create(:user) }
    let(:other_conversation) { create(:conversation_with_users_messages, user1: other_user) }
    subject do
      post "/api/v1/conversations/#{other_conversation.id}/messages",
           params: { user_id: user.id, body: 'TEST', conversation_id: other_conversation.id },
           headers: auth_headers, as: :json
    end

    it 'does not create the message' do
      expect { subject }.not_to change { other_conversation.messages.count }
    end
  end

  context 'when the body of the message is missing' do
    subject do
      post "/api/v1/conversations/#{conversation.id}/messages",
           params: { user_id: user.id, body: '', conversation_id: conversation.id },
           headers: auth_headers, as: :json
    end
    it 'does not create the message' do
      subject
      expect(response).to be_bad_request
    end
  end
end
