# テーブルの設計

## usersテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

### Association

- has_many :items
- has_many :favorites
- has_many :buys

## items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| name          | string     | null: false                    |
| price         | integer    | null: false                    |
| text          | text       | null: false                    |
| category_id   | integer    | null: false                    |
| condition_id  | integer    | null: false                    |
| burden_id     | integer    | null: false                    |
| date_id       | integer    | null: false                    |
| prefecture_id | integer    | null: false                    |
| user_id       | references | null: false, foreign_key: true |
| buy_id        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :favorites
- has_one :buy
- belongs_to_active_hash :category
- belongs_to_active_hash :condition
- belongs_to_active_hash :burden
- belongs_to_active_hash :date
- belongs_to_active_hash :prefecture

## favorites テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user_id   | references | null: false, foreign_key: true |
| item_id   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## addressesテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postcode        | string     | null: false                    |
| city            | string     | null: false                    |
| block           | string     | null: false                    |
| building        | string     |                                |
| phone_number    | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
| buy_id          | references | null: false, foreign_key: true |

### Association

- belongs_to_active_hash :prefecture
- belongs_to :buy

## buys テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user_id   | references | null: false  foreign_key: true |
| item_id   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address