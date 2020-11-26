class PurchasesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @item = Item.find(params[:item_id])
    if current_user == @item.user || @item.purchase != nil
      redirect_to root_path
    end
    @purchase_address = PurchaseAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      @purchase_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:postcode, :city, :block, :building, :phone_number, :prefecture_id).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
