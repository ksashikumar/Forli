class AutomationRule < ApplicationRecord
  serialize :filter_data
  serialize :action_data

  validates_presence_of :name
  validates_uniqueness_of :name
end
