class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_public_key, only: [:index, :create]

  def index
    @purchase_form = PurchaseForm.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    @item = Item.find(params[:item_id])
    if @purchase_form.valid?
      pay_item
      @purchase_form.save(params,current_user.id)
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end
  
  private

    def purchase_params
      params.require(:purchase_form).permit(
        :postal_code,
        :prefecture_id,
        :city,
        :street_number,
        :building,
        :phone_number,
        
      ).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
    end
    
    def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: purchase_params[:token],    # カードトークン
        currency: 'jpy'
      )
    end

    def set_public_key
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    end

end