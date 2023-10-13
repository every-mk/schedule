class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.belongs_to :group, null: false
      t.string :name, limit: 20, null: false
      t.integer :priority, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.boolean :notice_period, null: false
      t.text :content, limit: 300, null: true

      t.timestamps
    end
  end
end
