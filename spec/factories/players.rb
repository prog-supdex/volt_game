FactoryBot.define do
  factory :player do
    before(:create) do |player|
      player.team = create(:team) if player.team.blank?
    end

    name { Faker::Games::Dota.player }
  end
end
