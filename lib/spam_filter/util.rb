module SpamFilter::Util

  def akismet_params
    {
      blog: request.url,
      user_ip: request.remote_ip,
      referrer: request.referrer,
      user_agent: request.env['HTTP_USER_AGENT'],
      comment_type: 'comment',
      comment_author: self.user.name,
      comment_author_email: self.user.email,
      comment_content: content,
      key: Akismet::KEY
    }
  end

  def perform_spam_check
    spam_check_params = akismet_params

    spam_check_params[:is_test]     = 1 if Rails.env.development?
    spam_check_params[:spammable_id]   = self.id
    spam_check_params[:spammable_type] = self.class.to_s

    SpamFilter::SpamCheckWorker.perform_async(spam_check_params)
  end

  def spam_filter_enabled?
  end

end