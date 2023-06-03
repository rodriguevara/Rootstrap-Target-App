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
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:topic) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:radius) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lon) }
    it { is_expected.to validate_numericality_of(:radius).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:lat) }
    it { is_expected.to validate_numericality_of(:lon) }
  end

  context 'when the user has less than target limit' do
    let(:user) { create(:user) }
    it 'allows the creation of a target' do
      target = build(:target)
      expect(target).to be_valid
    end
  end

  context 'when the user has reached the limited number of targets' do
    let(:user1) { create(:user) }
    let(:target1) { create(:target) }
    let(:target2) { create(:target) }
    let(:target3) { create(:target) }

    before do
      user1.targets << [target1, target2, target3]
    end

    it 'does not allow the creation of a target' do
      target4 = build(:target, user: user1)
      expect(target4).to be_invalid
    end
  end
end
