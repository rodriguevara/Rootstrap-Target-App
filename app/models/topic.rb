# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  label      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topics_on_label  (label) UNIQUE
#
class Topic < ApplicationRecord
  validates :label, :image, presence: true
  validates :label, uniqueness: true

  has_one_attached :image, dependent: :destroy
end
