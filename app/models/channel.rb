class Channel < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, :about, presence: true
  validates_length_of :name, minimum: 5, maximum: 20
  validates_length_of :about, minimum: 5, maximum: 150

  has_one_attached :avatar
  validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                             size_range: 1..(5.megabytes) }

  has_many :videos, dependent: :destroy
  has_many :comments, dependent: :destroy
end
