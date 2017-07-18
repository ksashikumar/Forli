class PopulateAdminSettings < ActiveRecord::Migration[5.1]

  def self.up

  end

  def self.down
    AdminSetting.delete_all
  end
end
