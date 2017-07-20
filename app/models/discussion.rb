class Discussion < ApplicationRecord
  include SpamFilter::Util

  attr_accessor :request_url, :remote_ip, :referrer, :user_agent
  
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

  def add_tags(tag_names)
    tag_names.each do |tag_name|
      self.tags << Tag.find_or_create_by(name: tag_name)
    end
  end

  def remove_tags(tag_names)
    tag_names.each do |tag_name|
      tag = Tag.find_by_name(tag_name)
      self.discussion_tags.where(tag_id: tag.id).first.destroy
    end
  end
end
