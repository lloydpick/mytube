class YoutubedlUpdateJob < ApplicationJob
  include Delayed::RecurringJob

  run_every 6.hours
  queue_as :default

  def perform(*args)
    Rails.logger.debug "#{self.class.name}: Updating youtube-dl..."
    Terrapin::CommandLine.new("curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl").run
    Terrapin::CommandLine.new("chmod a+rx /usr/local/bin/youtube-dl").run
    Rails.logger.debug "#{self.class.name}: Done!"
  end
end
