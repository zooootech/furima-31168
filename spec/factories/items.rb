FactoryBot.define do
  factory :item do
    name               { Faker::Name.name }
    price              { 1000 }
    text               { Faker::Lorem.sentence }
    category_id        { 1 }
    condition_id       { 1 }
    shipping_charge_id { 1 }
    prefecture_id      { 1 }
    days_to_ship_id    { 1 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
