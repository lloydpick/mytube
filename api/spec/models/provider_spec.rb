require 'rails_helper'

RSpec.describe Provider, type: :model do
  it { should have_many(:channels).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_by) }
end