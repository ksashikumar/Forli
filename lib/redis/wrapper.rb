module Redis::Wrapper
  Redis.class_eval do
    def perform(operator, *args)
      Rails.logger.debug("REDIS: command: #{operator}")
      send(operator, *args)
    rescue Exception => e
      Rails.logger.error(e)
      return
    end
  end
end
