require 'rails_helper'

RSpec.describe "devise for channels", type: :request do
  let(:channel) { Channel.create(name: "Usuario12", email: "email@gmail.com", password: "password") }

  context 'Returns routes for no current channel' do
    it "returns route registration success" do
      get new_channel_registration_path
      expect(response).to have_http_status(:success)
    end

    it "returns route session success" do
      get new_channel_session_path
      expect(response).to have_http_status(:success)
    end
  end

  context "Devise routes for current channel" do
    before do
      sign_in channel
    end

    it 'returns route edit success' do
      get edit_channel_registration_path
      expect(response).to have_http_status(:success)
    end

    it "returns route destroy success" do
      delete destroy_channel_session_path

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
    end
  end
end
