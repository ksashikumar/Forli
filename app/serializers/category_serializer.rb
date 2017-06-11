class CategorySerializer < BaseSerializer
  attributes :name, :description, :visibility, :children
  belongs_to :user

  def children
    # TODO : This is not correct. Need to revisit with recursive logic
    object.children
  end
end