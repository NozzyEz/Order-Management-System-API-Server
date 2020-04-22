class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.boolean :is_thumb, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
