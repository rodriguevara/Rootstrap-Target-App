class MessagePolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def index?
    user.present?
  end
end
