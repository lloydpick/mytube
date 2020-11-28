class Video < ApplicationRecord

  belongs_to :channel

  validates_presence_of :title, :description, :url, :thumbnail_url, :published_at

end
