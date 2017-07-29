class UserSerializer < BaseSerializer
  attributes :name, :image, :karma, :last_seen
  attribute :email, if: :check_user

  def check_user
    current_user.id ==  object.id
  end
end
