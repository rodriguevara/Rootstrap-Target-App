# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  radius     :float            not null
#  lat        :float            not null
#  lon        :float            not null
#  user_id    :bigint           not null
#  topic_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_targets_on_topic_id  (topic_id)
#  index_targets_on_user_id   (user_id)
#
class Target < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  validate :user_targets_count, on: :create
  validates :title, presence: true
  validates :radius, presence: true, numericality: { greater_than: 0 }
  validates :lat, :lon, presence: true, numericality: true

  scope :from_other_users, ->(userid) { where.not(user_id: userid) }
  scope :with_same_topic, ->(topic) { where(topic_id: topic) }

  def user_targets_count
    return unless user.targets.count >= 3 && !user.vip?

    errors.add(:user, I18n.t('model.target.errors.invalid_amount'))
  end

  def compatible_targets
    Target.from_other_users(user_id).with_same_topic(topic_id)
  end
end
