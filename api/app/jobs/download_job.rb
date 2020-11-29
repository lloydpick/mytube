class DownloadJob < ApplicationJob
  queue_as :default

  def perform(video_id)
    Rails.logger.debug "#{self.class.name}: Downloading video #{video_id}"

    video = Video.find(video_id)
    options = {
      url: video.url,
      filename: "public/videos/#{video.channel.name} [#{video.channel.remote_id}]/Season #{video.published_at.year}/#{video.published_at.strftime("S%YE%m%d")} - %(title)s [%(id)s].%(ext)s"
    }

    line = Terrapin::CommandLine.new("youtube-dl -i --write-thumbnail --write-sub", "-o :filename :url")
    command = line.command(filename: options[:filename], url: options[:url])
    Rails.logger.debug "#{self.class.name}: Running #{command}"
    line.run(filename: options[:filename], url: options[:url])

    video.downloaded = 1
    video.save

    Rails.logger.debug "#{self.class.name}: Done!"
  end
end
