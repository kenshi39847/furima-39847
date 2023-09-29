class PurchasesController < ApplicationController
  def index
    @purchase_address = PurchaseAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      @purchase_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def purchase_params
    @item = Item.find(params[:item_id])
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :municipalities, :street, :building, :telephone_number).merge(user_id: current_user.id, item_id: @item.id)
  end
end
