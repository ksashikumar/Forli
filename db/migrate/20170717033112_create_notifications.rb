class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.text :content
      t.references :discussion, foreign_key: true

      t.timestamps
    end
  end
end
