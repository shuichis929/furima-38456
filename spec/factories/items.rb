FactoryBot.define do
  factory :item do
    item_name { '掃除機' }
    description { Faker::Lorem.sentence }
    category_id { '11' }
    condition_id { '7' }
    delivery_charge_id { '3' }
    prefecture_id { '48' }
    days_to_ship_id { '4' }
    price { '1000' }
    
    association :user
    
    after(:build) do |message|
      message.image.attach(io: File.open('public/images/item-sample.png'), filename: 'test_image.png')
    end
  end
end
