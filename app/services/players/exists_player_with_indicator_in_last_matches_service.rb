module Players::ExistsPlayerWithIndicatorInLastMatchesService
  MATCHES_LIMIT = 5

  def self.call(player:, indicator:)
    last_five_matches_by_team_scope =
      Match
        .joins(:players)
        .where(players: { team_id: player.team_id })
        .group('matches.id')
        .order(created_at: :desc)
        .limit(MATCHES_LIMIT)
        .select('matches.id')

    MatchPlayerIndicator
      .joins(:player)
      .where(player_id: player.id, indicator_id: indicator.id)
      .where(match_id: last_five_matches_by_team_scope).exists?
  end
end
