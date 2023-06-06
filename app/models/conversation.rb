# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Conversation < ApplicationRecord
  has_many :conversations_users, dependent: :destroy
  has_many :users, through: :conversations_users
  has_many :messages, dependent: :destroy

  def self.create_chat(current_user, other_user)
    return if already_created?(current_user, other_user)

    conversation = current_user.conversations.create!
    other_user.conversations << conversation
    conversation
  end

  def self.already_created?(current_user, other_user)
    result = false
    current_user.conversations.each do |conv|
      result = true if conv.users.include?(other_user)
    end
    result
  end

  private_class_method :already_created?
end
