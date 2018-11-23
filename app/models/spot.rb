class Spot < ApplicationRecord
  mount_uploader :image, ImageUploader
end
