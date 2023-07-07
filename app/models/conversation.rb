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
  has_many :messages, dependent: :destroy
end
