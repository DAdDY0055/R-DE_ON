class Spot < ApplicationRecord
  mount_uploader :spot_photo, ImageUploader

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def self.search(search) #self.でクラスメソッドとしている
    binding.pry
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Spot.where(['spot_tag LIKE ?', "%#{search}%"])
    else
      Spot.all #全て表示。
    end
  end
end
