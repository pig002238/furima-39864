class PurchaseHistoriesController < ApplicationController
  def index
    @purchase_form = PurchaseForm.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.valid?
      @purchase_form.save(params,current_user.id)
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
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
      ).merge(item_id: params[:item_id], user_id: current_user.id)
    end
    

end