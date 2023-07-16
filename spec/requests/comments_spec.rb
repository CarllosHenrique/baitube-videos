require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:channel) { Channel.create(name: "user1dx", email: "user@example.com", password: "password") }

  before do
    sign_in channel
  end

  context 'Comments routes' do
    it 'returns create comment http redirect' do
      video = Video.create(
        title: 'VideoTitle',
        description: 'Video Description',
        identity: '1EnciVkwyD0',
        channel:,
        video_url: 'https://www.youtube.com/watch?v=1EnciVkwyD0'
      )

      post video_comments_path(video.slug), params: { comment: { content: 'Novo comentário' } }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(video_path(video.slug))
    end
  end
end
