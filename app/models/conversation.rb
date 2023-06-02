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

  def self.create_chat(user1, user2)
    return if already_created?(user1, user2)

    conversation = user1.conversations.create!
    user2.conversations << conversation
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
