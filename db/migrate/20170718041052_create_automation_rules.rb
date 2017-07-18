class CreateAutomationRules < ActiveRecord::Migration[5.1]
  def change
    create_table :automation_rules do |t|
      t.string :name,
      t.text :description,
      t.boolean :match_all,
      t.integer :when,
      t.text :filter_data,
      t.text :action_data,
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
