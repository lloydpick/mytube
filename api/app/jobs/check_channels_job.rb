class CheckChannelsJob < ApplicationJob
  include Delayed::RecurringJob

  run_every 1.hour
  queue_as :default

  def perform(*args)
    Rails.logger.debug "#{self.class.name}: Checking all channels for videos"
    Channel.all.each do |channel|
      Rails.logger.debug "#{self.class.name}: Making job for channel #{channel.id}"
      FetchMetaJob.perform_later(channel.id)
    end
    Rails.logger.debug "#{self.class.name}: Done!"
  end
end
