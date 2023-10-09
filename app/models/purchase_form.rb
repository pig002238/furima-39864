class PurchaseForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :street_number, :building, :phone_number, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :city
    validates :street_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :item_id
    validates :user_id
    validates :token
  end
  

  def save(params,user_id)
    purchase_history = PurchaseHistory.create(item_id: item_id, user_id: user_id)
    
    DeliveryAddress.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      street_number: street_number,
      building: building,
      phone_number: phone_number, 
      purchase_history_id: purchase_history.id
    )
  end
end
