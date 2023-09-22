class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.belongs_to :group, null: false
      t.belongs_to :user, null: false
      t.text :content, limit: 300, null: false

      t.timestamps
    end
  end
end
