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
FactoryBot.define do
  factory :conversation do
    factory :conversation_with_users_messages do
      transient do
        user1    { create(:user) }
        user2    { create(:user) }
        msg_count { 1 }
      end
      after(:create) do |conversation1, evaluator|
        conversation1.users << evaluator.user1
        conversation1.users << evaluator.user2
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation1,
          sender: evaluator.user1
        )
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation1,
          sender: evaluator.user2
        )
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation1,
          sender: evaluator.user1
        )
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation1,
          sender: evaluator.user1
        )
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation1,
          sender: evaluator.user1
        )
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation1,
          sender: evaluator.user1
        )
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation1,
          sender: evaluator.user1
        )
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation1,
          sender: evaluator.user1
        )
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation1,
          sender: evaluator.user1
        )
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation1,
          sender: evaluator.user1
        )
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation1,
          sender: evaluator.user1
        )
      end
    end
  end
end
