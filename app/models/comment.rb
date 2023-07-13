class Comment < ApplicationRecord
  belongs_to :video
  belongs_to :channel

  validates :content, presence: true
  validates :content, length: { maximum: 150 }
end
