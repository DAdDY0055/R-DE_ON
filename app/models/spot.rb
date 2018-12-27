class Spot < ApplicationRecord
  validates :spot_name, :spot_infomation, :spot_photo, presence: true
  mount_uploader :spot_photo, ImageUploader

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  scope :square_brackets_del, -> { delete("[").delete("]") }
  scope :tag_search, -> (tag) { where('spot_tag like ?', "%#{tag}%") }
end
