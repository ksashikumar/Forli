class SpamFilter::SpamCheckWorker

  include Sidekiq::Worker

  sidekiq_options :queue => :spam_check_worker, :retry => 0, :backtrace => true

  def perform(options)
    spammable_id, spammable_type = options.extract!(:spammable_id, :spammable_type)

    if AkismetClient.spam?(options)
      spammable = Object.const_get(spammable_type).find_by_id(spammable_id)
      spammable.update_attributes(spam: true)
    end
  end

end