class CreateInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :invites do |t|
      t.belongs_to :meeting, null: false
      t.belongs_to :user, null: false
      t.integer :kind, null: false

      t.timestamps
    end
  end
end
