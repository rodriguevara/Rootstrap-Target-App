describe 'Admin Topics', type: :request do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:topics) { create_list(:topic, 2) }
  let!(:topic) { FactoryBot.create(:topic, label: 'Rspec test Topic') }

  before do
    sign_in admin_user
  end

  describe 'POST Create' do
    it 'creates a new topic' do
      image = StringIO.new(Faker::LoremPixel.image)

      blob = ActiveStorage::Blob.create_and_upload!(
        io: image,
        filename: 'random_image.png',
        content_type: 'image/png'
      )
      expect {
        post '/admin/topics', params: {
          topic: {
            label: 'Rspec Lovers',
            image: blob.signed_id
          }
        }
      }.to change { Topic.count }.by(1)

      topic = Topic.last
      expect(topic.label).to eq('Rspec Lovers')
      expect(response).to redirect_to(admin_topic_path(topic))
    end
  end

  describe 'PUT Edit' do
    it 'edits an existing topic' do
      put "/admin/topics/#{topic.id}", params: { topic: { label: 'Updated Topic Label' } }

      expect(topic.reload.label).to eq('Updated Topic Label')
      expect(response).to redirect_to(admin_topic_path(topic.id))
    end
  end

  describe 'DELETE Destroy' do
    it 'destroys an existing topic' do
      expect {
        delete "/admin/topics/#{topic.id}"
      }.to change { Topic.count }.by(-1)

      expect(response).to redirect_to(admin_topics_path)
    end
  end
end
