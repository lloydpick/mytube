require 'rails_helper'

RSpec.describe Video, type: :model do
  it { should belong_to(:channel) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:thumbnail_url) }
  it { should validate_presence_of(:published_at) }
end
