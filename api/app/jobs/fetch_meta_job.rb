class FetchMetaJob < ApplicationJob
  queue_as :default

  def perform(channel_id)
    Rails.logger.debug "#{self.class.name}: Fetching IDs for #{channel_id}"

    channel = Channel.find(channel_id)
    provider_videos = channel.provider.entity.send("check_#{channel.category}", channel.remote_id)
    
    provider_videos.each do |entry|
      puts entry.inspect
      Rails.logger.debug "#{self.class.name}: Handling #{entry[:id]}"
      video = channel.videos.find_or_initialize_by(remote_id: entry[:id])
      video.title = entry[:title]
      video.description = entry[:description]
      video.url = entry[:url]
      video.thumbnail_url = entry[:thumbnail_url]
      video.published_at = DateTime.parse(entry[:published_at])
      video.save
    end
    
    Rails.logger.debug "#{self.class.name}: Done!"
  end
end
