# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# テストユーザー
User.create(
  nickname: "teamA",
  email: "test@gmail.com",
  password: "testtest123",
  last_name: "A",
  first_name: "チーム",
  last_name_kana: "エー",
  first_name_kana: "チーム",
  birth_year: 1900,
  birth_month: 1,             
  birth_day: 31,               
  zipcode: 7010001,                 
  prefecture_id: 1,           
  city: "高知市",                    
  address: "1-1",                 
  delivery_last_name: "A",      
  delivery_first_name: "チーム",     
  delivery_last_name_kana: "エー", 
  delivery_first_name_kana: "チーム",
)

#親要素
lady = Category.create(:name=>"レディース")

mens = Category.create(:name=>"メンズ")

interior = Category.create(:name=>"インテリア")
#子要素
lady_tops = lady.children.create(:name=>"トップス")
lady_jacket = lady.children.create(:name=>"ジャケット/アウター")
lady_shoes = lady.children.create(:name=>"靴")

mens_tops = mens.children.create(:name=>"トップス")
mens_jacket = mens.children.create(:name=>"ジャケット/アウター")
mens_shoes = mens.children.create(:name=>"靴")

interior_kitchen = interior.children.create(:name=>"キッチン/食器")
interior_bed = interior.children.create(:name=>"ベッド/マッドレス")
#孫要素
lady_tops.children.create([{:name=>"Tシャツ/カットソー(半袖/袖なし)"}, {:name=>"Tシャツ/カットソー(七分/長袖)"},{:name=>"その他"}])
lady_jacket.children.create([{:name=>"テーラードジャケット"}, {:name=>"ノーカラージャケット"}, {:name=>"Gジャン/デニムジャケット"},{:name=>"その他"}])
lady_shoes.children.create([{:name=>"ハイヒール/パンプス"}, {:name=>"ブーツ"},{:name=>"サンダル"}])

mens_tops.children.create([{:name=>"Tシャツ/カットソー(半袖/袖なし)"}, {:name=>"Tシャツ/カットソー(七分/長袖)"},{:name=>"その他"}])
mens_jacket.children.create([{:name=>"テーラードジャケット"}, {:name=>"ノーカラージャケット"}, {:name=>"Gジャン/デニムジャケット"},{:name=>"その他"}])
mens_shoes.children.create([{:name=>"スニーカー"}, {:name=>"サンダル"},{:name=>"モカシン"}])

interior_kitchen.children.create([{:name=>"食器"},{:name=>"調理器具"},{:name=>"弁当用品"},{:name=>"その他"}])
interior_bed.children.create([{:name=>"シングルベッド"},{:name=>"ダブルベッド"},{:name=>"クイーンベッド"},{:name=>"その他"}])
# サイズ要素


#####  products_sizesテーブル用  #####
ProductsSize.create(size: "洋服のサイズ", ancestry: nil)
ProductsSize.create(size: "XXS以下", ancestry: 1)
ProductsSize.create(size: "XS(SS)", ancestry: 1)
ProductsSize.create(size: "S", ancestry: 1)
ProductsSize.create(size: "M", ancestry: 1)
ProductsSize.create(size: "L", ancestry: 1)
ProductsSize.create(size: "XL(LL)", ancestry: 1)
ProductsSize.create(size: "2XL(3L)", ancestry: 1)
ProductsSize.create(size: "3XL(4L)", ancestry: 1)
ProductsSize.create(size: "4XL(5L)以上", ancestry: 1)
ProductsSize.create(size: "FREE SIZE", ancestry: 1)
ProductsSize.create(size: "メンズ靴のサイズ", ancestry: nil)
ProductsSize.create(size: "23.5 cm以下", ancestry: 12)
ProductsSize.create(size: "24 cm", ancestry: 12)
ProductsSize.create(size: "24.5 cm", ancestry: 12)
ProductsSize.create(size: "25 cm", ancestry: 12)
ProductsSize.create(size: "25.5 cm", ancestry: 12)
ProductsSize.create(size: "26 cm", ancestry: 12)
ProductsSize.create(size: "26.5 cm", ancestry: 12)
ProductsSize.create(size: "27 cm", ancestry: 12)
ProductsSize.create(size: "27.5 cm", ancestry: 12)
ProductsSize.create(size: "28 cm", ancestry: 12)
ProductsSize.create(size: "28.5 cm", ancestry: 12)
ProductsSize.create(size: "29 cm", ancestry: 12)
ProductsSize.create(size: "30 cm", ancestry: 12)
ProductsSize.create(size: "30.5 cm", ancestry: 12)
ProductsSize.create(size: "31 cm以上", ancestry: 12)
ProductsSize.create(size: "レディース靴のサイズ", ancestry: nil)
ProductsSize.create(size: "20 cm以下", ancestry: 28)
ProductsSize.create(size: "20.5 cm", ancestry: 28)
ProductsSize.create(size: "21 cm", ancestry: 28)
ProductsSize.create(size: "21.5 cm", ancestry: 28)
ProductsSize.create(size: "22 cm", ancestry: 28)
ProductsSize.create(size: "22.5 cm", ancestry: 28)
ProductsSize.create(size: "23 cm", ancestry: 28)
ProductsSize.create(size: "23.5 cm", ancestry: 28)
ProductsSize.create(size: "24 cm", ancestry: 28)
ProductsSize.create(size: "24.5 cm", ancestry: 28)
ProductsSize.create(size: "25 cm", ancestry: 28)
ProductsSize.create(size: "25.5 cm", ancestry: 28)
ProductsSize.create(size: "26 cm", ancestry: 28)
ProductsSize.create(size: "26.5 cm", ancestry: 28)
ProductsSize.create(size: "27 cm", ancestry: 28)
ProductsSize.create(size: "27.5 cm以上", ancestry: 28)

#####  products_sizesテーブル用  #####
CategorySize.create(category_id: "4", products_size_id: "1")
CategorySize.create(category_id: "5", products_size_id: "1")
CategorySize.create(category_id: "6", products_size_id: "28")
CategorySize.create(category_id: "7", products_size_id: "1")
CategorySize.create(category_id: "8", products_size_id: "1")
CategorySize.create(category_id: "9", products_size_id: "12")