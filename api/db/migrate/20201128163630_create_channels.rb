class CreateChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :channels do |t|
      t.string :remote_id
      t.string :name
      t.string :category
      t.references :provider, null: false, foreign_key: true
      t.integer :created_by

      t.timestamps
    end
  end
end
