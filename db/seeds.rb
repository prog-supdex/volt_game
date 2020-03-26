Indicator.create(name: 'пробежал 10км')
Indicator.create(name: '70% точных передач')
Indicator.create(name: Faker::Lorem.word)

Team.create(name: Faker::Games::Dota.team)
Team.create(name: Faker::Games::Dota.team)

Team.all.each do |team|
  5.times do
    team.players.create(name: Faker::Games::Dota.player)
  end
end

3.times do
  Match.create(name: Faker::Lorem.word)
end

indicator_ids = Indicator.ids << nil
players_ids = Player.limit(6).order(created_at: :desc).ids

Match.ids.each do |match_id|
  players_ids.each do |player_id|
    MatchPlayerIndicator.create(match_id: match_id, player_id: player_id, indicator_id: indicator_ids.sample)
  end
end

