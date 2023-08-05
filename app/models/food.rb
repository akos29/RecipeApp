class Food < ApplicationRecord
  has_many :recipe_foods, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :user_id, message: ' of food is already in your list'
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
