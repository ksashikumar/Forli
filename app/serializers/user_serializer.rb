class UserSerializer < BaseSerializer
  attributes :name, :image, :karma, :last_seen
  attribute :email, if: :check_user
  attribute :preferences, if: :check_user

  def preferences
    object.preferences_hash
  end

  def check_user
    current_user.id ==  object.id
  end
end
