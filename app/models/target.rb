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
  validate :targets_count, on: :create
  validates :title, presence: true
  validates :radius, presence: true, numericality: { greater_than: 0 }
  validates :lat, :lon, presence: true, numericality: true
  belongs_to :user
  belongs_to :topic

  def targets_count
    return unless user.targets.count >= 3

    errors.add(:base, "You can't create more than 3 targets")
  end
end
