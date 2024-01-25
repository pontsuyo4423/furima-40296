## usersテーブル

| Column          | Type   | Options                |
| --------------- | ------ | ---------------------- |
| nickname        | string | null:false,unique:true |
| email           | string | null:false,unique:true |
| password        | string | null:false             |
| last_name       | string | null:false             |
| first_name      | string | null:false             |
| last_name_kana  | string | null:false             |
| first_name_kana | string | null:false             |
| birthday        | date   | null:false             |

### Association
has_many :items
has_many :orders

## itemsテーブル

| Column           | Type       | Options                     |
| ---------------- | ---------- | --------------------------- |
| user             | references | null:false,foreign_key:true |
| name             | string     | null:false                  |
| description      | text       | null:false                  |
| category         | string     | null:false                  | 
| item_status      | string     | null:false                  |
| shipping_charges | string     | null:false                  |
| region           | string     | null:false                  |
| shipping-date    | date       | null:false                  | 
| price            | integer    | null:false                  |

### Association
belongs_to :user
has_one :order

## ordersテーブル

| Column | Type       | Options                     |
| ------ | ---------- | --------------------------- |
| user   | references | null:false,foreign_key:true |
| item   | references | null:false,foreign_key:true |

### Association
belongs_to :user
belongs_to :item
has_one :payments

## paymentsテーブル
| Column          | Type   | Options                |
| --------------- | ------ | ---------------------- |
| orders          | references | null:false, foreign_key:true |
| postcode        | string     | null:false |
| city            | string     | null:false |
| block           | string     | null:false |
| building        | string     |            |
| phone_number    | string     | null:false |

### Association
belongs_to :order

