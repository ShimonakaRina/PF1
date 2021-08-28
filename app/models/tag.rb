class Tag < ApplicationRecord
  has_many   :tag_relationships, dependent: :destroy
  has_many   :cooks, through: :tag_relationships
  validates :name, length: { maximum: 10 }
end
