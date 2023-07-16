require 'rails_helper'

RSpec.describe "channel routes", type: :request do
  let(:channel) { Channel.create(name: "user1dx", email: "user@example.com", password: "password") }

  context "My channel routes" do
    before do
      sign_in channel
    end
    it "returns http channel success" do
      get my_channel_path
      expect(response).to have_http_status(:success)
    end

    it "returns http edit success" do
      get my_channel_edit_path
      expect(response).to have_http_status(:success)
    end

    it 'returns HTTP patch redirect' do
      patch my_channel_update_path, params: { channel: { name: 'testes1', about: 'wdwdwdwdwd' } }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(my_channel_path)
    end

    it 'returns http subscribe channel redirect' do
      post subscribe_channel_path(channel)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(user_channel_path(channel))
    end

    it 'returns http unsubscribe channel redirect' do
      delete unsubscribe_channel_path(channel)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(user_channel_path(channel))
    end
  end

  context "User channel routes" do
    it "returns http user channel success" do
      get user_channel_path(channel.name)
      expect(response).to have_http_status(:success)
    end
  end
end
