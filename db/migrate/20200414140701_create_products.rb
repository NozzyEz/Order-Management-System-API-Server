class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.belongs_to :organization, null: false, foreign_key: true
      t.text :description
      t.integer :inventory
      t.float :price

      t.timestamps
    end
  end
end
