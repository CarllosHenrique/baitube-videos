require 'rails_helper'

RSpec.describe "Videos", type: :request do
  let(:channel) { Channel.create(name: "Usuario12", email: "email@gmail.com", password: "password") }
  let(:video) do
    Video.create(
      title: 'VideoTitle',
      description: 'Video Description',
      identity: '1EnciVkwyD0',
      channel:,
      video_url: 'https://www.youtube.com/watch?v=1EnciVkwyD0'
    )
  end

  it 'returns show video route' do
    get video_path(video.slug)

    expect(response).to have_http_status(:success)
  end

  context 'Resources routes to video(signIn required)' do
    before do
      sign_in channel
    end

    it "returns new video route" do
      get new_video_path
      expect(response).to have_http_status(:success)
    end
  end
end
