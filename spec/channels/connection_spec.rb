require 'rails_helper'

describe ApplicationCable::Connection, type: :channel do
  let(:user) { create(:user) }

  before(:each) do
    @auth = user.create_new_auth_token
  end

  it 'successfully connects' do
    connect "/cable?access-token=#{@auth['access-token']}" \
            "&client=#{@auth['client']}&uid=#{@auth['uid']}"
    expect(connection.current_user).to eq(user)
  end
end
