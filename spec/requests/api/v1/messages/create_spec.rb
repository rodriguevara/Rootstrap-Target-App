require 'rails_helper'

describe 'POST /api/v1/conversations/:conversation_id/messages', type: :request do
  let!(:user)  { create(:user) }
  let(:user2)  { create(:user) }
  let(:topic)  { create(:topic) }
  let!(:conversation1) { create(:conversation, topic_id: topic.id) }
  let!(:conversations_user1) { create(:conversations_user, user:, conversation: conversation1) }
  let!(:conversations_user2) { create(:conversations_user, user: user2, conversation: conversation1) }

  context 'when the request is valid' do

    subject do
      post "/api/v1/conversations/#{conversation1.id}/messages",
           params: { body: 'test', conversation: conversation1, user_id: user.id },
           headers: auth_headers, as: :json
    end

    it 'returns a successful response' do
      subject

      expect(response).to be_successful
    end

    it 'creates the message' do
      expect { subject }.to change(Message, :count)
    end

    it 'returns the message in the correct format' do
      subject
      expect(json[:message][:body]).to eq('test')
      expect(json[:message][:sender]).to eq(User.find_by(id: user.id).username)
    end
  end

  context 'when the user does not belong to the conversation' do
    let(:other_user) { create(:user) }
    subject do
      post "/api/v1/conversations/#{conversation1.id}/messages",
           params: { body: 'TEST for unauthorized user', conversation: conversation1, user_id: other_user.id },
           headers: auth_headers, as: :json
    end

    it 'does not returns a successful response' do
      subject
      expect(response).to be_bad_request
    end

    it 'does not create the message' do
      expect { subject }.not_to change { conversation1.messages.count }
    end
  end

  context 'when the body of the message is missing' do
    subject do
      post "/api/v1/conversations/#{conversation1.id}/messages",
           params: { body: '', conversation: conversation1, user_id: user.id },
           headers: auth_headers, as: :json
    end

    it 'does not return a successful response' do
      subject
      expect(response).to be_bad_request
    end

    it 'does not create the message' do
      expect { subject }.not_to change { conversation1.messages.count }
    end
  end
end
