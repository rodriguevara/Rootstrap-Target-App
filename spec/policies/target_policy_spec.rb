describe TargetPolicy do
  subject { described_class }

  permissions :create? do
    let(:user) { create(:user) }

    it 'allows access to create a target' do
      expect(subject).to permit(user)
    end
  end

  permissions :destroy? do
    let(:user) { create(:user) }

    it 'allows access to destroy if target belongs to the user' do
      target = create(:target, user:)
      expect(subject).to permit(user, target)
    end

    it 'denies access to destroy if target doesnt belong to the user' do
      target = create(:target)
      expect(subject).not_to permit(user, target)
    end
  end
end
