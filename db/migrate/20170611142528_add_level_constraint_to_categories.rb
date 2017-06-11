class AddLevelConstraintToCategories < ActiveRecord::Migration[5.1]
  def up
    execute "ALTER TABLE categories ADD CONSTRAINT check_category_level CHECK (level >= 0 AND level <= 5 )"
  end

  def down
    execute "ALTER TABLE categories DROP CONSTRAINT check_category_level"
  end
end
