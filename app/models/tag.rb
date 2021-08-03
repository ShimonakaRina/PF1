class Tag < ApplicationRecord
  has_many   :tag_relationships, dependent: :destroy
  has_many   :cooks, through: :tag_relationships
end
