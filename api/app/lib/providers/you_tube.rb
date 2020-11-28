module Providers
  class YouTube

    require "net/http"

    def supported_categories
      ['channel', 'playlist']
    end

    def self.check_channel(id)
      uri = URI.parse("https://www.youtube.com/feeds/videos.xml?channel_id=#{id}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.get(uri.request_uri)

      parse_feed(response.body)
    end

    def self.check_playlist(id)
      uri = URI.parse("https://www.youtube.com/feeds/videos.xml?playlist_id=#{id}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.get(uri.request_uri)

      parse_feed(response.body)
    end

    private

    def self.parse_feed(xml)
      doc = Nokogiri::XML(xml)
      doc.remove_namespaces!

      doc.xpath('//entry').inject([]) do |arr,feed_item|
        arr << {
          id: feed_item.xpath("videoId").text,
          title: feed_item.xpath("group/title").text,
          description: feed_item.xpath("group/description").text,
          thumbnail_url: feed_item.xpath("group/thumbnail").attr("url").value,
          url: feed_item.xpath("link").attr("href").value,
          published_at: feed_item.xpath("published").text
        }
      end
    end

  end
end
