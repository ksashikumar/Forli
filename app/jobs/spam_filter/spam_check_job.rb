class SpamFilter::SpamCheckJob < ApplicationJob
  queue_as :spam_check

  def perform(options)
    begin
      spammable_hash = options.extract!(:spammable_id, :spammable_type)
      spammable_id = spammable_hash[:spammable_id]
      spammable_type = spammable_hash[:spammable_type]

      spammable = Object.const_get(spammable_type).find_by_id(spammable_id)

      options[:key] = Akismet::KEY
      options[:comment_content]      = spammable.content
      options[:comment_author]       = spammable.user.name,
      options[:comment_author_email] = spammable.user.email

      spammable.update_column(:spam, true) if SpamFilter::AkismetClient.spam?(options)
    rescue Exception => e
      Rails.logger.error("Exception in spam_check: #{e.inspect}")
    end
  end
end