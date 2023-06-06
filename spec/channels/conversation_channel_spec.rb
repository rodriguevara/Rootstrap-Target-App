require 'rails_helper'

RSpec.describe ConversationChannel, type: :channel do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  # let(:conversation) { create(:conversation, user1: user1, user2: user2) }
  let!(:conversation) { create(:conversation, users: [user1, user2]) }

  before do
    stub_connection current_user: user1
    subscribe(conversation_id: conversation.id)
  end

  it 'subscribes to a stream' do
    expect(subscription).to be_confirmed
  end

  it 'broadcasts a new message' do
    expect {
      perform :receive, { 'user_id' => user1.id, 'body' => 'Hello, World!' }
    }.to have_broadcasted_to(conversation).with(a_hash_including('body' => 'Hello, World!'))
  end
end
