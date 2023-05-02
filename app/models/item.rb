class Item < ApplicationRecord

  has_many :order_detail #中間テーブル
  has_many :orders, through: :ordered_items
  has_many :cart_items

  has_one_attached :image

  validates :price, presence: true

  ## 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end
end
