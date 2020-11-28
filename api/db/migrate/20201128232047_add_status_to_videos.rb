class AddStatusToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :downloaded, :integer, default: 0, after: 'remote_id'
  end
end
