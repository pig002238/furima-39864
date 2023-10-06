FactoryBot.define do
  factory :purchase_form do
    postal_code { "123-4567" }  # 郵便番号
    prefecture_id { Faker::Number.between(from: 1, to: 47) }  # 都道府県ID
    city { Faker::Address.city }  # 市区町村
    street_number { Faker::Address.street_address }  # 住所
    phone_number { "12345678901" }
  # 電話番号
    item_id  { Faker::Number.unique.number(digits: 5) }  # ユニークな商品ID
    user_id  { Faker::Number.unique.number(digits: 5) }  # ユニークなユーザーID
  end
end