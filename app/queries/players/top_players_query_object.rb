module Players::TopPlayersQueryObject
  TOP_PLAYERS_LIMIT = 5

  def self.call(indicator:, team: nil)
    scope =
      Player
        .select('COUNT(indicator_id) AS cn_indicators, players.id')
        .joins(match_player: :match_player_indicators)
        .where(match_player_indicators: { indicator_id: indicator.id })
        .group('indicator_id, players.id')
        .order('cn_indicators DESC')
        .limit(TOP_PLAYERS_LIMIT)

    return scope if team.blank?

    scope.where(players: { team: team })
  end
end
