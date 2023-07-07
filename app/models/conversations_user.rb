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
class ConversationsUser < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
end
