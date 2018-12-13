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

  def self.search(search)
    if search # Controllerから渡されたパラメータが存在する場合(チェックボックスが選択された場合)spot_tagカラムを部分一致検索
      tag = search.delete("[").delete("]") # 検索条件から部分一致で検索する際、邪魔になる"["と"]"を削除する
      Spot.where('spot_tag like ?', "%#{tag}%")
    else
      Spot.all # チェックボックスが選択されていない場合、全て表示。
    end
  end
end
