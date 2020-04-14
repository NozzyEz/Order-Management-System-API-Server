class CreateOrdersProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :orders_products do |t|
      t.references :orders, null: false, foreign_key: true
      t.references :products, null: false, foreign_key: true

      t.timestamps
    end
  end
end
