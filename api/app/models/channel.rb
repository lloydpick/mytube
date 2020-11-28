class Channel < ApplicationRecord

  belongs_to :provider
  has_many :videos, dependent: :destroy

  validates_presence_of :name, :remote_id, :created_by

end
