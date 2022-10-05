FactoryBot.define do
  factory :purchase_shipping_address do
    token { 'tok_abcdefghijk00000000000000000' }
    post_code { '123-4567' }
    prefecture_id { '48' }
    city { '横浜市' }
    block { '緑区' }
    building { '柳ビル103' }
    phone_number { '09012345678' }
    
  end
end
