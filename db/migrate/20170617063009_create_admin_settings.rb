class CreateAdminSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_settings do |t|
      t.string :name
      t.text :data

      t.timestamps
    end
  end
end
