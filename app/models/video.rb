class Video < ApplicationRecord
  belongs_to :channel
  has_many :comments, dependent: :destroy

  extend FriendlyId
  friendly_id :identity, use: :slugged

  validates :identity, :title, :video_url, :description, presence: true

  validates :title, :identity, :video_url, length: { minimum: 10, maximum: 150 }
  validates :description, length: { minimum: 15, maximum: 5000 }

  def like
    self.likes += 1
    save
  end

  def dislike
    self.deslikes += 1
    save
  end

  def denounce
    self.denounces += 1
    save
  end
end
