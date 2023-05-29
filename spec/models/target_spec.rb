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
require 'rails_helper'

RSpec.describe Target, type: :model do
  describe 'validations' do
    subject { build :target }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:radius) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lon) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:topic) }
    it { is_expected.to validate_numericality_of(:radius).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:lat) }
    it { is_expected.to validate_numericality_of(:lon) }
  end

  context 'when the user has 0 targets' do
    let!(:user_1) { create(:user, first_name: nil, last_name: nil) }
    let!(:target) {create(:target, title: 'test', radius: 5, lat: 33, lon: 58, user: user_1)}

    it 'is created successfully' do
      binding.pry
    end
  end
end
