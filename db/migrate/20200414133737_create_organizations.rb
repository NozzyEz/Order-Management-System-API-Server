class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :verification_code

      t.timestamps
    end

    change_table :users do |t|
      t.belongs_to :organization, null: true, foreign_key: true
    end
  end
end
