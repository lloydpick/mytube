class Provider < ApplicationRecord

  has_many :channels, dependent: :destroy

  validates_presence_of :name

  def entity
    "Providers::#{name}".constantize
  end

end
