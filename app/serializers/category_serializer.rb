class CategorySerializer < BaseSerializer
  attributes :name, :description
  belongs_to :user
  has_many   :categories, serializer: CategorySerializer
end
