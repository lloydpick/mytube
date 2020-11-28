require 'rails_helper'

RSpec.describe Channel, type: :model do
  it { should belong_to(:provider) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:url) }
end