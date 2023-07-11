# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#  body            :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { create(:message) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to belong_to(:sender) }
  end
end
