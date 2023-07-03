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
class Conversation < ApplicationRecord
  belongs_to :topic
  has_many :conversations_users, dependent: :destroy
  has_many :users, through: :conversations_users

  def self.create_chat(current_user, other_user, topicid)
    return if already_created?(current_user, other_user)

    conversation = current_user.conversations.create!(topic_id: topicid)
    other_user.conversations << conversation
    conversation
  end

  def self.already_created?(current_user, other_user)
    current_user.conversations.any? { |conversation| conversation.users.include?(other_user) }
  end

  private_class_method :already_created?
end
