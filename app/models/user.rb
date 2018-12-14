class User < ApplicationRecord
  mount_uploader :icon, ImageUploader

  has_many :spots
  has_many :favorites, dependent: :destroy
  has_many :favorites_spots, through: :favorites, source: :spot

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
