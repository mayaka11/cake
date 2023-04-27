class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_detail

  validates :price, presence: true
end
