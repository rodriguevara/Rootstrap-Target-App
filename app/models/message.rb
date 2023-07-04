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
class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: :User, foreign_key: 'user_id', inverse_of: :messages

  validates :body, presence: true
  validate :sender_from_conversation
  MAX_MESSAGES = ENV['MAX_MESSAGES'].freeze
  cattr_reader :max_messages

  private

  def sender_from_conversation
    return if conversation.users.include?(sender)

    errors.add(:sender, I18n.t('model.message.errors.invalid_sender'))
  end
end
