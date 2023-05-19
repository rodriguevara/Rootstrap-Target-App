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
FactoryBot.define do
  factory :topic do
    label { Faker::Name.unique.name }
    after(:build) do |topic|
      topic.image.attach(io: File.open('app/assets/images/futbol.png'), filename: 'futbol.png')
    end
  end
end
