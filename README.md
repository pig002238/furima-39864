# 

```markdown
# テーブル設計

## users テーブル

| Column                     | Type   | Options     |
| -------------------------- | ------ | ----------- |
| nickname                   | string | null: false |
| email                      | string | unique: true|
| encrypted_password         | string | null: false |
| first_name                 | string | null: false |
| last_name                  | string | null: false |
| first_name_kana            | string | null: false |
| last_name_kana             | string | null: false |
| date_birth                 | date   | null: false |

### Association

- has_many :items
- has_many :delivery_addresses

## items テーブル

| Column                 | Type       | Options                            |
| ---------------------- | ---------- | ---------------------------------- |
| item                   | string     | null: false                        |
| description            | text       | null: false                        |
| category_id            | integer    | null: false                        |
| condition_id           | integer    | null: false                        |
| shipping_charge_id     | integer    | null: false                        |
| prefecture_id          | integer    | null: false                        |
| shipping_date_id       | integer    | null: false                        |
| price                  | integer    | null: false                        |
| user                   | references | null: false, foreign_key: true     |

### Association

- belongs_to :user
- has_one :purchase_history

## purchase_histories テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :delivery_address

## delivery_addresses テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| postal_code         | string     | null: false |
| prefecture_id       | integer    | null: false |
| city                | string     | null: false |
| street_number       | string     | null: false |
| building            | string     |             |
| phone_number        | string     | null: false |
| purchase_history    | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_history
```