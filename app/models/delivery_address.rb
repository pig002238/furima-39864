class DeliveryAddress < ApplicationRecord
  belongs_to :purchase_history

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id
    validates :city
    validates :street_number
    validates :phone_number
    validates :purchase_history
  end
end
