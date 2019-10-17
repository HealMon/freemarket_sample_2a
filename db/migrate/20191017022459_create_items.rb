class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,                 null: false
      t.string :description,          null: false
      t.integer :price,               null: false
      t.string :condition,            null: false
      t.string :shipping_charge,      null: false
      t.string :shipping_method,      null: false
      t.integer :prefecture_id,       null: false
      t.string :estimated_delivery,   null: false
      t.integer :trade_status,        null: false

      t.timestamps
    end
  end
end
