FactoryBot.define do
  factory :purchase_address do
    token { 'tok_abcdefghijk00000000000000000' }
    postcode { '123-4567' }
    city { '福岡市' }
    block { '中央区' }
    building { '福岡ハイツ' }
    phone_number { '09012345678' }
    user_id { 1 }
    item_id { 1 }
    prefecture_id { 1 }
  end
end
