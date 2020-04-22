class ChangeOrderPaidToBool < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :paid
    add_column :orders, :paid, :boolean
  end
end
