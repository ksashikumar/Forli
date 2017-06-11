class AddLevelConstraintToComments < ActiveRecord::Migration[5.1]
  def up
    execute "ALTER TABLE comments ADD CONSTRAINT check_comment_level CHECK (level >= 0 AND level <= 15 )"
  end

  def down
    execute "ALTER TABLE comments DROP CONSTRAINT check_comment_level"
  end
end
