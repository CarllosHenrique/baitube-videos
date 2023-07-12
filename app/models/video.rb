class Video < ApplicationRecord
  belongs_to :channel

  extend FriendlyId
  friendly_id :identity, use: :slugged

  validates :identity, :title, :video_url, :description, presence: true

  validates :title, :identity, :video_url, length: { minimum: 10, maximum: 50 }
  validates :description, length: { minimum: 15, maximum: 1500 }
end
