class MetaInfo::VoteDumpJob < ApplicationJob
  queue_as :vote_dump

  def perform(options); end
end
