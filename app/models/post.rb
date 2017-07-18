class Post < ApplicationRecord
  belongs_to :discussion
  belongs_to :user
  has_many :comments, as: :commentable

  NOTIFIABLE_TYPE = 'post'

  def get_notifiable_type
	NOTIFIABLE_TYPE
  end

end
