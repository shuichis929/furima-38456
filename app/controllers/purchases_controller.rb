class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    @item = Item.find(params[:item_id])
    @purchase_shipping_address = PurchaseShippingAddress.new
    redirect_to root_path if current_user.id == @item.user_id || @item.purchase.present?
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_shipping_address = PurchaseShippingAddress.new(purchase_params)
    if @purchase_shipping_address.valid?
      pay_item
      @purchase_shipping_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render 'purchases/index'
    end
  end

  private

  def purchase_params
    params.require(:purchase_shipping_address).permit(:post_code, :prefecture_id, :city, :block, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
