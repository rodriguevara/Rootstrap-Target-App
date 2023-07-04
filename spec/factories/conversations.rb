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
    factory :conversation_with_users do
      association :user1, factory: :user
      association :user2, factory: :user
      topic_id { 1 }
    end
    # transient do
    #   user1    { create(:user) }
    #   user2    { create(:user) }
    # end
    # after(:create) do |conversation, evaluator|
    #   conversation.users << evaluator.user1
    #   conversation.users << evaluator.user2
    # end
    # end
  end
end
