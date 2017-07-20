module SpamFilter::Util

  def akismet_params
    {
      blog: request_url,
      user_ip: remote_ip,
      referrer: referrer,
      user_agent: user_agent,
      comment_type: 'comment'
    }
  end

  def perform_spam_check
    spam_check_params = akismet_params

    spam_check_params[:is_test]     = 1 if Rails.env.development?
    spam_check_params[:spammable_id]   = self.id
    spam_check_params[:spammable_type] = self.class.to_s

    SpamFilter::SpamCheckJob.perform_later(spam_check_params)
  end

  def spam_filter_enabled?
  end

end