# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#親要素
lady = Category.create(:name=>"レディース")

mens = Category.create(:name=>"メンズ")

interior = Category.create(:name=>"インテリア")
#子要素
lady_tops = lady.children.create(:name=>"トップス")
lady_jacket = lady.children.create(:name=>"ジャケット/アウター")

mens_tops = mens.children.create(:name=>"トップス")
mens_jacket = mens.children.create(:name=>"ジャケット/アウター")

interior_kitchen = interior.children.create(:name=>"キッチン/食器")
interior_bed = interior.children.create(:name=>"ベッド/マッドレス")
#孫要素
lady_tops.children.create([{:name=>"Tシャツ/カットソー(半袖/袖なし)"}, {:name=>"Tシャツ/カットソー(七分/長袖)"},{:name=>"その他"}])
lady_jacket.children.create([{:name=>"テーラードジャケット"}, {:name=>"ノーカラージャケット"}, {:name=>"Gジャン/デニムジャケット"},{:name=>"その他"}])

mens_tops.children.create([{:name=>"Tシャツ/カットソー(半袖/袖なし)"}, {:name=>"Tシャツ/カットソー(七分/長袖)"},{:name=>"その他"}])
mens_jacket.children.create([{:name=>"テーラードジャケット"}, {:name=>"ノーカラージャケット"}, {:name=>"Gジャン/デニムジャケット"},{:name=>"その他"}])

interior_kitchen.children.create([{:name=>"食器"},{:name=>"調理器具"},{:name=>"弁当用品"},{:name=>"その他"}])
interior_bed.children.create([{:name=>"シングルベッド"},{:name=>"ダブルベッド"},{:name=>"クイーンベッド"},{:name=>"その他"}])
