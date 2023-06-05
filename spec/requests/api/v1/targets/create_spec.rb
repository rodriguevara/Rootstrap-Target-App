describe 'POST api/v1/targets', type: :request do
  let(:user) { create(:user) }
  let(:topic)           { create(:topic) }
  let(:target)          { Target.last }

  describe 'POST create' do
    subject { post api_v1_targets_path, params:, headers: auth_headers, as: :json }
    let(:title)           { 'test' }
    let(:radius)          { 5 }
    let(:lat)             { -33.8866 }
    let(:lon)             { -58.6688 }
    let(:topic_id)        { topic.id }

    let(:params) do
      {
        title:,
        radius:,
        lat:,
        lon:,
        topic_id:
      }
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'creates the target' do
      expect { subject }.to change(Target, :count).from(0).to(1)
    end

    it 'returns the target' do
      subject
      expect(json[:target][:title]).to eq(target.title)
      expect(json[:target][:radius]).to eq(target.radius)
      expect(json[:target][:lat]).to eq(target.lat)
      expect(json[:target][:lon]).to eq(target.lon)
      expect(json[:target][:topic_id]).to eq(target.topic_id)
    end

    context 'when radius is incorrect' do
      let(:radius) { 'incorrect_radius' }

      it 'does not create a target' do
        expect { subject }.not_to change { Target.count }
      end

      it 'does not return a successful response' do
        subject
        expect(response).to be_bad_request
      end
    end

    context 'when latitude or longitude is incorrect' do
      let(:lat) { 'invalid_latitude' }
      let(:lon) { 'invalid_longitude' }

      it 'does not create a target' do
        expect { subject }.not_to change { Target.count }
      end

      it 'does not return a successful response' do
        subject
        expect(response).to be_bad_request
      end
    end

    context 'when the user has a maximum 3 targets created' do
      let!(:user_targets) { create_list(:target, 3, user:) }

      it 'does not create the target' do
        expect { subject }.not_to change { Target.count }
      end

      it 'does not return a successful response' do
        subject
        expect(response).to be_bad_request
      end

      it 'returns the error message' do
        subject
        expect(json[:errors][:user].first).to eq(I18n.t('model.target.errors.invalid_amount'))
      end
    end
  end
end
