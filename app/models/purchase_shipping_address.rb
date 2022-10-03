class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :block, :building, :phone_number, :purchase_id
end