class Spot < ApplicationRecord
  mount_uploader :spot_photo, ImageUploader
end
