class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :remote_id
      t.string :title
      t.text :description
      t.string :url
      t.string :thumbnail_url
      t.references :channel, null: false, foreign_key: true
      t.datetime :published_at

      t.timestamps
    end
  end
end
