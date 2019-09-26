# README

TECH::EXPERT KOCHI ２期Aチームのリポジトリです

## user TB
|    |Column|Type|Options|
|----|------|------|-------|
|ユーザーID|  |     |       |  |
|ニックネーム|nickname|string|null: false, unique: true|
|メールアドレス|email|string|null: false, unique: true|
|パスワード|password|string|null: false|
|電話番号|phone_number|string||
|郵便番号|zipcode|string||
|都道府県ID|prefecture_id|integer||
|市区町村ID|city_id|string||
|番地|address|string||
|建物名|building|string||
|生年月日|birthday|integer|null: false|
|名前(漢字)(苗字)|last_name|string|null: false|
|名前(漢字)(名前)|first_name|string¥null: false|
|名前(カナ)(苗字)|last_name_kana|string|null: false|
|名前(カナ)(名前)|first_name_kana|string|null :false|
|プロフィールイメージ|profile_image|string||
|プロフィール|profile|string||

### Association
- has_many :items
- has_many :trading_partners
- has_many :creadit_cards

## item TB
|    |column|Type|Options|
|----|------|----|-------|
|商品ID|     |    |       |
|商品イメージID|item_image_id|string|null: false|
|商品名|item_name|string|null: false|
|商品説明 ( 1000字まで)|description|string|null: false|
|価格|price|integer|null: false|
|カテゴリーID|category_id|refences|null: false,foreign_key: true|
|状態(汚れなど)|condition|string|null: false|
|ブランドID|brand|references|foreign_key: true|
|サイズID|size_id|references|foreign_key: true|
|配送料の負担(どっちも)|shipping_charge|string|null: false|
|発想の方法|shipping_method|string|null: false|
|都道府県ID(発想の地域)|prefecture_id|integer|null: false|
|発想の目安|estimated_delivery|string|null: false|
|商品出品状態（出品中,売却済み)|trade_status|string||
|商品者ID|user_id|references|null: false, foreign_key: true|

### Association
- has_many :images
- has_many :orders
- belongs_to :category
- belongs_to :user

## item_image TB
|     |Column|Type|Options|
|-----|------|----|-------|
|イメージ名|image_name|string|null: false|
|商品ID|item_id|references|null: false,foreign_key: true|

### Association
belongs_to :item

## size TB
|-|Colimn|Type|Options|
|-|------|----|-------|
|サイズID| |   |   |
|サイズ名|size_name|string|null: false,unique: true|

## brand TB
| |Column|Type|Options|
|-|------|----|-------|
|ブランドID| |    |   |
|ブランドID|brand_name|string|null: false,unique: true|

### Association
- has_many :items

## categorie TB
| |Column|Type|Options|
|-|------|----|-------|
|カテゴリーID| | | |
|カテゴリー名|categorie_name|string| |
|カテゴリー子要素ID|categorie_group_id|integer|foreign_key: true|

 ### Association
- has_many :items
- has_many :categori_group

## categorie_group TB
| |Column|Type|Options|
|-|------|----|-------|
|カテゴリー子要素ID| | | |
|カテゴリー子要素名|categorie_child_name|string| |
|カテゴリー子要素2ID|categorie_child2_id| | |

### Association
- has_may :categorie_group2
- belongs_to :categorie

## categorie_group2 TB
| |Column|Type|Options|
|-|------|----|-------|
|カテゴリー子要素2ID| | | |
|カテゴリー子要素名2|categorie_child2_name|string| |

### Association
- belongs_to :categorie_group

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

## prefecture TB
| |Column|Type|Options|
|-|------|----|-------|
|都道府県ID| | | |
|都道府県|prefecture|string||

### Association
- has_many :city

## city TB
| |Coiumn|Type|Options|
|-|------|----|-------|
|市区町村ID| | | |
|都道府県ID|prefecture|integer|foreign_key: true|
|市区町村|city|string| |

### Association
- belongs_to :prefecture

## credit_card TB
| |Column|Type|Options|
|-|------|----|-------|
|クレジットカードID| | | |
|カード番号|card-number|integer|null: false|
|有効期限|exporation_date|integer|null: false|
|セキュリティーコード|cvc|integer|null: false|
|ユーザID|user_id|references|null: false,foreign_key: true|

### Association
- belongs_to :uesr