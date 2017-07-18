class CreateAdminSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_settings do |t|
      t.string :type,
      t.boolean :enabled
      t.text :data

      t.timestamps
    end
    add_index :admin_settings, :type, unique: true
  end
end
