class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.string :card_number,     null: false
      t.integer :exporation_year,  null: false
      t.integer :exporation_month,  null: false
      t.integer :cvc,             null: false
      t.references :user,         null: false, foreign_key: true 
      
      t.timestamps
    end
  end
end