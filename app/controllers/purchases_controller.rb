class PurchasesController < ApplicationController
  before_action :set_public_key, only: [:index, :create]
  before_action :item_purchase, only: [:index, :create]

  def index
    @purchase_address = PurchaseAddress.new
    if user_signed_in?
      if @item.user.id == current_user.id || @item.purchase.present?
        redirect_to root_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def purchase_params
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :municipalities, :street, :building, :telephone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def item_purchase
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    Payjp::Charge.create(
      amount: @item.price, 
      card: purchase_params[:token], 
      currency: 'jpy' 
    )
  end

  def set_public_key
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end
end
