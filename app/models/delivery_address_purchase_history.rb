class DonationAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street_number, :phone_number, :purchase_history
end

with_options presence: true do
  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :prefecture_id
  validates :city
  validates :street_number
  validates :phone_number
  validates :purchase_history
end

def save
  donation = Donation.create(item_id: item_id, user_id: user_id)
  Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, street_number: street_number, building: building, purchase_history: purchase_history)
end