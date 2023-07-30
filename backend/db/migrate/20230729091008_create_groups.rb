class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.integer :space, null: false
      t.string :name, limit: 20, null: false
      t.text :content, limit: 300

      t.timestamps
    end
  end
end
