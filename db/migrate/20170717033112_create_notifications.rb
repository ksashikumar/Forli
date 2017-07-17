class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.text :contact
      t.references :post_id, foreign_key: true

      t.timestamps
    end
  end
end
