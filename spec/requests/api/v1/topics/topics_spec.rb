describe 'GET api/v1/topics', type: :request do
  let(:user) { create(:user) }
  let!(:topics)       { create_list(:topic, 10) }
  let(:first_topic)   { topics.first }
  subject { get api_v1_topics_path, headers: auth_headers, as: :json }

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'returns all topics' do
    subject
    expect(json[:topics].pluck(:label)).to match_array(topics.pluck(:label))
  end

  it 'returns topics in correct format' do
    subject
    expect(json[:topics].first[:id]).to eq(first_topic.id)
    expect(json[:topics].first[:label]).to eq(first_topic.label)
    expect(json[:topics].first[:created_at]).to eq(first_topic.created_at.as_json)
    expect(json[:topics].first[:updated_at]).to eq(first_topic.updated_at.as_json)
  end
end
