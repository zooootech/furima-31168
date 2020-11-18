class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :days_to_ship

  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :price
    validates :text
    validates :image
  end

  validates :name, length: { maximum: 40 }
  validates :text, length: { maximum: 1000 }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}

  with_options numericality: { greater_than_or_equal_to: 1 } do
    validates :category_id
    validates :condition_id
    validates :shipping_charge_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

end
