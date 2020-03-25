FactoryBot.define do
  factory :player do
    name { Faker::Games::Dota.player }
  end
end
