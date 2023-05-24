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
require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'validations' do
    subject { build :topic }
    it { is_expected.to validate_presence_of(:label) }
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_uniqueness_of(:label) }
  end
end
