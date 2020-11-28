FactoryBot.define do
  factory :channel do
    name { Faker::Movies::StarWars.character }
    url { Faker::Internet.url(host: 'youtube.com', scheme: 'https') }
  end
end