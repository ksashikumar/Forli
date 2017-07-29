class UserSerializer < BaseSerializer
  attributes :name, :email, :image, :karma, :last_seen
end
