class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :organization, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.boolean :paid
      t.string :status
      t.string :payment_type

      t.timestamps
    end
  end
end
