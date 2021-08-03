class CookComment < ApplicationRecord
  belongs_to :user
  belongs_to :cook
  validates :comment, presence: true
end
