class Category < ApplicationRecord

  enum visibility: [:open, :moderator_only, :admin_only]
  has_ancestry
end
