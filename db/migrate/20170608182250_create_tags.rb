class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name, limit: 30, null: false
      t.integer :count, default: 0

      t.timestamps
    end
    add_index :tags, :name, unique: true
  end
end
