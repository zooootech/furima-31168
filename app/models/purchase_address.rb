class PurchaseAddress
  include ActiveModel::Model
  attr_accessor  :user_id, :item_id, :postcode, :city, :block, :building, :phone_number, :prefecture_id, :token

  VALID_PHONE_NUMBER_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
  VALID_POSTCODE_REGEX = /\A\d{3}[-]\d{4}\z/

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postcode
    validates :city
    validates :block
    validates :phone_number
    validates :prefecture_id, numericality: { greater_than_or_equal_to: 1, message: "can't be blank" }
  end

  validates :postcode, format: { with: VALID_POSTCODE_REGEX }, allow_blank: true
  validates :phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }, allow_blank: true

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postcode: postcode, city: city, block: block, building: building, phone_number: phone_number, prefecture_id: prefecture_id, purchase_id: purchase.id)
  end
end
