class ConversationPolicy < ApplicationPolicy
  def index
    user.present?
  end
end
