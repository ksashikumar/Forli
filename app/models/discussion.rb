class Discussion < ApplicationRecord
  include SpamFilter::Util

  validates_presence_of :title

  belongs_to :user
  belongs_to :category, optional: true
  has_many :posts
  has_many :comments, as: :commentable
  has_many :discussion_tags
  has_many :tags, through: :discussion_tags
  has_many :notifications

  after_commit :perform_spam_check, on: :create #, :if => :spam_filter_enabled?

  def content
    "#{title} #{description}"
  end

end
