require 'rails_helper'

RSpec.describe Channel, type: :model do
  context "Attributes to create a channel" do
    it "Is valid" do
      channel = Channel.new(name: 'channel',
                            slug: 'channel',
                            about: 'this is my channel',
                            email: 'my@example.com',
                            password: 'mypassword',
                            subscribed_channels: %w[user1 user2])
      expect(channel).to be_valid
    end

    it "Is invalid" do
      channel = Channel.new(name: nil,
                            slug: nil,
                            about: nil,
                            email: nil,
                            password: nil)
      expect(channel).to_not be_valid
      att = [:name, :about, :email, :password]

      att.each do |wkey|
        expect(channel.errors[wkey]).to include("can't be blank")
      end
    end
  end

  context 'Name validation characters' do
    it 'Valid more than 5 characters' do
      channel = Channel.new(name: 'Channel', email: 'email@example.com', password: 'password')
      expect(channel).to be_valid
      expect(channel.errors[:name]).to_not include("is too short (minimum is 5 characters)")
    end

    it 'Invalid less than 5 characters' do
      channel = Channel.new(name: 'Chan', email: 'email@example.com', password: 'password')
      expect(channel).to_not be_valid
      expect(channel.errors[:name]).to include("is too short (minimum is 5 characters)")
    end

    it 'Invalid more than 20 characters' do
      channel = Channel.new(name: 'C' * 21, email: 'email@example.com', password: 'password')
      expect(channel).to_not be_valid
      expect(channel.errors[:name]).to include("is too long (maximum is 20 characters)")
    end
  end

  context 'About validation characters' do
    it 'Valid more than 5 characters' do
      channel = Channel.new(name: 'channel',
                            about: 'this is my channel',
                            email: 'my@example.com',
                            password: 'mypassword')
      expect(channel).to be_valid
      expect(channel.errors[:about]).to_not include("is too short (minimum is 5 characters)")
    end

    it 'Invalid less than 5 characters' do
      channel = Channel.new(name: 'channel',
                            about: 'This',
                            email: 'my@example.com',
                            password: 'mypassword')
      expect(channel).to_not be_valid
      expect(channel.errors[:about]).to include("is too short (minimum is 5 characters)")
    end

    it 'Invalid more than 150 characters' do
      channel = Channel.new(name: 'channel',
                            about: 's' * 151,
                            email: 'my@example.com',
                            password: 'mypassword')
      expect(channel).to_not be_valid
      expect(channel.errors[:about]).to include("is too long (maximum is 150 characters)")
    end
  end

  context 'Validation of attribute avatar' do
    it 'allows valid image types' do
      channel = Channel.new(name: 'channel',
                            about: 'this is my channel',
                            email: 'my@example.com',
                            password: 'mypassword')
      valid_image_types = ['image/png', 'image/jpg', 'image/jpeg']
      valid_image_types.each do |content_type|
        channel.avatar.attach(io: File.open('spec/fixtures/archives/image.jpeg'), filename: 'image.jpeg', content_type:)
        expect(channel).to be_valid
      end
    end
  end
end
