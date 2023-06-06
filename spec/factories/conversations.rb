# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :conversation do
    factory :conversation_with_users_messages do
      transient do
        user1    { create(:user) }
        user2    { create(:user) }
        msg_count { 1 }
      end
      after(:create) do |conversation, evaluator|
        conversation.users << evaluator.user1
        conversation.users << evaluator.user2
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation,
          sender: evaluator.user1
        )
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation,
          sender: evaluator.user2
        )
      end
    end
  end
end
