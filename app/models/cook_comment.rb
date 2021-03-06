class CookComment < ApplicationRecord
  belongs_to :user
  belongs_to :cook
  validates :comment, presence: true
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5
  }, presence: true
end
