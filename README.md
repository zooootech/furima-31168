# テーブルの設計

## usersテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | nill: false |
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
| category      | integer    | null: false                    |
| condition     | integer    | null: false                    |
| burden        | integer    | null: false                    |
| date          | integer    | null: false                    |
| prefecture_id | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :favorites
- has_many :users, through: :favorites
- has_one :buy
- belongs_to :prefecture

## favorites テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## addressesテーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| postcode        | string     | null: false |
| city            | string     | null: false |
| block           | string     | null: false |
| building        | string     |             |
| phone_number    | string     | null: false |
| prefecture_id   | integer    | null: false |

### Association

- has_many :buys
- belongs_to :prefecture

## prefecturesテーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### Association

- has_many :items
- has_many :addresses

## buys テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false  foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :addresses