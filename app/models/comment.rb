class Comment < ApplicationRecord
  belongs_to :spot
  validates :content, presence: true
end
