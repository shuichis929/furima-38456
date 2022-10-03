class PurchasesController < ApplicationController
  def index
    @purchase_shipping_address = PurchaseShippingAddress.new
  end

  def create
    @purchase_shipping_address = PurchaseShippingAddress.new(purchase_params)
  end

  private

  def purchase_params
    params.require(:purchase_shipping_address).merge(user_id: current_user.id, item_id: item[:id])
  end
end
