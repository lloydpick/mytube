FactoryBot.define do
  factory :provider do
    name { Faker::Movies::StarWars.character }
    created_by { Faker::Number.number(digits: 3) }
  end
end