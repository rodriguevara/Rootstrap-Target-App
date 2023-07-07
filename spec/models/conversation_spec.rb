# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint           not null
#
# Indexes
#
#  index_conversations_on_topic_id  (topic_id)
#
require 'rails_helper'

RSpec.describe Conversation, type: :model do
  subject { create(:conversation_with_users_messages) }
  subject { create(:conversation) }

  context 'validations' do
    it { is_expected.to have_many(:messages) }
    it { is_expected.to have_many(:users) }
  end
end
