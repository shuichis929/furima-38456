require 'rails_helper'

RSpec.describe PurchaseShippingAddress, type: :model do
  before do
    @purchase_shipping_address = FactoryBot.build(:purchase_shipping_address)
  end
  
  describe '商品購入機能' do
    context '商品が購入できる場合' do
      it "tokenと post_code, prefecture_id, city, block, phone_numberが存在すれば登録できる" do
        expect(@purchase_shipping_address).to be_valid
      end
      it "tokenと post_code, prefecture_id, city, block, phone_numberが存在し、buildingが空でも登録できる" do
        @purchase_shipping_address.building = ''
        expect(@purchase_shipping_address).to be_valid
      end
    end
    context '商品が購入できない場合' do
      it "tokenが空の場合は購入できない" do
        @purchase_shipping_address.token = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
      it "post_codeが空の場合は購入できない" do
        @purchase_shipping_address.post_code = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Post code can't be blank")
      end
      it "post_codeに-(ハイフン)が含まれていなければ購入できない" do
        @purchase_shipping_address.post_code = '1234567'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it "post_codeが3桁-(ハイフン)4桁でなければ購入できない" do
        @purchase_shipping_address.post_code = '123-456'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it "prefecture_idが空の場合は購入できない" do
        @purchase_shipping_address.prefecture_id = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "prefecture_idに --- が選択されている場合は購入できない" do
        @purchase_shipping_address.prefecture_id = 1
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "cityが空の場合は購入できない" do
        @purchase_shipping_address.city = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("City can't be blank")
      end
      it "blockが空の場合は購入できない" do
        @purchase_shipping_address.block = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Block can't be blank")
      end
      it "phone_numberが空の場合は購入できない" do
        @purchase_shipping_address.phone_number = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it "phone_numberに数値以外が含まれていれば購入できない" do
        @purchase_shipping_address.phone_number = '090-1234-5678'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end
      it "phone_numberが全角数値の場合は購入できない" do
        @purchase_shipping_address.phone_number = '０９０１２３４５６７８'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end
      it "phone_numberが10桁以上11桁以内でなければ購入できない" do
        @purchase_shipping_address.phone_number = '090123456'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end


