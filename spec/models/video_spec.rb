require 'rails_helper'

RSpec.describe Video, type: :model do
  let(:channel) do
    Channel.create(
      name: 'channel',
      slug: 'channel',
      about: 'this is my channel',
      email: 'my@example.com',
      password: 'mypassword'
    )
  end

  context 'Attributes to create a video' do
    it 'is valid' do
      video = Video.new(
        title: 'VideoTitle',
        description: 'Video Description',
        identity: '1EnciVkwyD0',
        channel:,
        video_url: 'https://www.youtube.com/watch?v=1EnciVkwyD0',
        likes: 23,
        deslikes: 21
      )

      expect(video).to be_valid
    end

    it 'is invalid' do
      video = Video.new(
        title: nil,
        description: nil,
        identity: nil,
        channel:,
        video_url: nil,
        likes: nil,
        deslikes: nil
      )

      expect(video).to_not be_valid
      att = [:title, :description, :identity, :video_url]

      att.each do |key|
        expect(video.errors[key]).to include("can't be blank")
      end
    end
  end

  context 'title, url, identity validation characters' do
    it 'Valid more than 10 characters' do
      video = Video.new(
        title: 'v' * 10,
        description: 'Video Description',
        identity: 'i' * 10,
        channel:,
        video_url: 'u' * 10
      )
      expect(video).to be_valid
    end

    it 'Invalid less than 10 characters' do
      video = Video.new(
        title: 'Video',
        description: 'Desc',
        identity: '2dx',
        channel:,
        video_url: 'https'
      )
      expect(video).to_not be_valid
      att = [:title, :identity, :video_url]

      att.each do |key|
        expect(video.errors[key]).to include("is too short (minimum is 10 characters)")
      end
    end

    it 'Invalid more than 150 characters' do
      video = Video.new(
        title: 'V' * 151,
        description: 'Video Description',
        identity: '1' * 151,
        channel:,
        video_url: 'https' * 151
      )
      expect(video).to_not be_valid
      att = [:title, :identity, :video_url]

      att.each do |key|
        expect(video.errors[key]).to include("is too long (maximum is 150 characters)")
      end
    end
  end

  context 'description validation characters' do
    it 'Valid more than 15 characters' do
      video = Video.new(
        title: 'v' * 10,
        description: 'D' * 15,
        identity: '1EnciVkwyD0',
        channel:,
        video_url: 'https://www.youtube.com/watch?v=1EnciVkwyD0'
      )
      expect(video).to be_valid
    end

    it 'Invalid less than 15 characters' do
      video = Video.new(
        title: 'v' * 10,
        description: 'Description',
        identity: '1EnciVkwyD0',
        channel:,
        video_url: 'https://www.youtube.com/watch?v=1EnciVkwyD0'
      )
      expect(video).to_not be_valid
      expect(video.errors[:description]).to include("is too short (minimum is 15 characters)")
    end

    it 'Invalid more than 5000 characters' do
      video = Video.new(
        title: 'v' * 10,
        description: 'D' * 5001,
        identity: '1EnciVkwyD0',
        channel:,
        video_url: 'https://www.youtube.com/watch?v=1EnciVkwyD0'
      )
      expect(video).to_not be_valid
      expect(video.errors[:description]).to include("is too long (maximum is 5000 characters)")
    end
  end
end
