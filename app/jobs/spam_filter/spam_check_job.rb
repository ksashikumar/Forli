class SpamFilter::SpamCheckJob < ApplicationJob
  queue_as :spam_check

  def perform(options)
    spammable_id, spammable_type = options.slice!(:spammable_id, :spammable_type)

    if AkismetClient.spam?(options)
      spammable = Object.const_get(spammable_type).find_by_id(spammable_id)
      spammable.update_attributes(spam: true)
    end
  end
end