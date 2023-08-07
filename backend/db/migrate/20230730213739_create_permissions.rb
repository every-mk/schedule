class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.belongs_to :group, null: false, unique: true
      t.belongs_to :user, null: false, unique: true
      t.integer :privilege, null: false
      t.boolean :join, null: false
      t.boolean :post, null: false

      t.timestamps
    end
  end
end
