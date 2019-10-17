# README

## user TB
|    |Column|Type|Options|
|----|------|------|-------|
|ユーザーID|  |     |       |  |
|ニックネーム|nickname|string|null: false, unique: true|
|メールアドレス|email|string|null: false, unique: true|
|パスワード|password|string|null: false|
|電話番号|phone_number|string||
|郵便番号|zipcode|string|null: false|
|都道府県ID|prefecture_id|integer|null: false|
|市区町村|city|string|null: false|
|番地|address|string|null: false|
|建物名|building|string||
|生年月日(年)|birth_year|integer|null: false|
|生年月日(月)|birth_month|integer|null: false|
|生年月日(日)|birth_day|integer|null: false|
|名前(漢字)(苗字)|last_name|string|null: false|
|名前(漢字)(名前)|first_name|string|null: false|
|名前(カナ)(苗字)|last_name_kana|string|null: false|
|名前(カナ)(名前)|first_name_kana|string|null :false|
|プロフィールイメージ|avatar|string||
|プロフィール|profile|string||
|お届け先名前(漢字)(苗字)|delivery_last_name|string|null: false|
|お届け先名前(漢字)(名前)|delivery_first_name|string|null: false|
|お届け先名前(カナ)(苗字)|delivery_last_name_kana|string|null: false|
|お届け先名前(カナ)(名前)|delivery_first_name_kana|string|null: false|
|お届け先電話番号|delivery_phone_number|string||

### Association
- has_many :items , dependent: :destroy
- has_many :trading_partners , dependent: :destroy
- has_many :creadit_cards , dependent: :destroy

## item TB
|    |column|Type|Options|
|----|------|----|-------|
|商品ID|     |    |       |
|商品名|name|string|null: false|
|商品説明 (1000字まで)|description|string|null: false|
|価格|price|integer|null: false|
|カテゴリーID|category_id|references|null: false,foreign_key: true|
|状態(汚れなど)|condition|string|null: false|
|ブランドID|brand|references|foreign_key: true|
|サイズID|size_id|references|foreign_key: true|
|配送料の負担(どっちも)|shipping_charge|string|null: false|
|発送の方法|shipping_method|string|null: false|
|都道府県ID(発送の地域)|prefecture_id|integer|null: false|
|発送の目安|estimated_delivery|string|null: false|
|商品出品状態（出品中,売却済み)|trade_status|integer|null: false|
|商品者ID|user_id|references|null: false, foreign_key: true|

### Association
- has_many :images , dependent: :destroy
- has_many :orders , dependent: :destroy
- belongs_to :category
- belongs_to :user

## item_image TB
|     |Column|Type|Options|
|-----|------|----|-------|
|商品イメージID| |   |   |
|イメージ名|name|string|null: false|
|商品ID|item_id|references|null: false,foreign_key: true|

### Association
belongs_to :item

## size TB
|-|Colimn|Type|Options|
|-|------|----|-------|
|サイズID| |   |   |
|サイズ名|name|string|null: false,unique: true|

## brand TB
| |Column|Type|Options|
|-|------|----|-------|
|ブランドID| |    |   |
|ブランドID|name|string|null: false,unique: true|

### Association
- has_many :items

## categorie TB
| |Column|Type|Options|
|-|------|----|-------|
|カテゴリーID| | | |
|カテゴリー名|name|string| |
|カテゴリー子要素ID|categorie_group_id|integer||

 ### Association
- has_many :items

## order TB
| |Column|Type|Options|
|-|------|----|-------|
|取引ID| | | |
|商品ID|item_id|references|null: false, foreign_key: true|
|取引対象ID|trading_partner_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item
- belongs_to :trading_partner

## trading_partner TB
| |Column|Type|Options|
|-|------|----|-------|
|取引対象ID| | | |
|販売者ID|seller_id|references|null: false,foreign_key: {to_table: :user}|
|購入者ID|buyer_id|references|null: false,foreign_key: {to_table: :user}|

### Association
- belongs_to :buyer, class_name: "User"
- belongs_to :seller, class_name: "User"
- has_many:orders

## credit_card TB
| |Column|Type|Options|
|-|------|----|-------|
|クレジットカードID| | | |
|カード番号|card_number|string|null: false|
|有効期限(年)|exporation_year|string|null: false|
|有効期限(月)|exporation_month|string|null: false|
|セキュリティーコード|cvc|integer|null: false|
|ユーザID|user_id|references|null: false,foreign_key: true|

### Association
- belongs_to :user
