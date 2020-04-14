class AddOrganizationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :org_id, :integer
  end
end
