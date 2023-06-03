class TargetPolicy < ApplicationPolicy
  def create?
    user_present?
  end

  def destroy?
    user_present? && user_target?
  end

  private

  def user_target?
    record.user == user
  end

  def user_present?
    user.present?
  end
end
