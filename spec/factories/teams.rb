FactoryBot.define do
  factory :team do
    name { Faker::Games::Dota.team }
  end
end
