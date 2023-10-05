class PurchaseHistoriesController < ApplicationController
  def index
    @purchase_form = PurchaseForm.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_history = Purchase.new(purchase_params)
    if @purchase_history.save
      # 購入が成功した場合の処理
      # 配送先情報を保存する場合の例:
      @delivery_address = DeliveryAddress.new(delivery_address_params)
      @delivery_address.purchase = @purchase_history
      if @delivery_address.save
        redirect_to root_path, notice: '購入が完了しました。'
      else
        # 配送先情報の保存に失敗した場合の処理
        # エラーメッセージを表示するか、エラーページにリダイレクトするなどの対応が必要
        render :new
      end
    else
      render :new
    end
  end

  private

  def purchase_params
    params.require(:purchase_form).permit(:user_id, :item_id, :postal_code, :prefecture_id, :city, :street_number, :building, :phone_number)
  end
end

def delivery_address_params
  params.require(:delivery_address).permit(:postal_code, :prefecture_id, :city, :street_number, :building, :phone_number)
end