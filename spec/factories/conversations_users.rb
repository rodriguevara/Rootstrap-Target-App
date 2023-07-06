# == Schema Information
#
# Table name: conversations_users
#
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_conversations_users_on_conversation_id_and_user_id  (conversation_id,user_id)
#
FactoryBot.define do
  factory :conversations_user do
    user
    conversation
  end
end
