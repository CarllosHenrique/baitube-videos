require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:channel) do
    Channel.create(
      name: 'channel',
      slug: 'channel',
      about: 'this is my channel',
      email: 'my@example.com',
      password: 'mypassword'
    )
  end
  let(:video) do
    Video.create(
      title: 'VideoTitle',
      description: 'Video Description',
      identity: '1EnciVkwyD0',
      channel:,
      video_url: 'https://www.youtube.com/watch?v=1EnciVkwyD0',
      likes: 23,
      deslikes: 21
    )
  end

  context 'Validates content presence' do
    it 'is valid' do
      comment = Comment.new(
        content: 'Content of comment',
        channel:,
        video:
      )

      expect(comment).to be_valid
    end

    it 'is invalid' do
      comment = Comment.new(
        content: nil,
        channel:,
        video:
      )

      expect(comment).to_not be_valid
    end
  end

  context 'content validation characters' do
    it 'is invalid more than 150' do
      comment = Comment.new(
        content: "c" * 151,
        channel:,
        video:
      )

      expect(comment).to_not be_valid
    end
  end
end
