class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.datetime :last_seen, null: false
      t.integer :karma, default: 0
      t.boolean :active, default: false
      t.integer :role, default: 0
      t.boolean :deleted, default: false

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
