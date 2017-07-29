class Tag < ApplicationRecord
  has_many :discussion_tags
  has_many :discussions, through: :discussion_tags

  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false

  scope :name_like, ->(name) {
    where(['LOWER(name) LIKE LOWER(?)', "#{name}%"])
  }

  def self.find_or_create_by_name(*args)
    options = args.extract_options!
    options[:name] = args[0] if args[0].is_a?(String)
    case_sensitive = options.delete(:case_sensitive)
    conditions = if case_sensitive
                   ['name = ?', options[:name]]
                 else
                   ['UPPER(name) = ?', options[:name].upcase]
                 end
    self.where(conditions).first || create(options)
  end
end
