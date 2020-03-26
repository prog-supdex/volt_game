module Players::ExistsPlayerWithIndicatorInLastMatchesService
  def self.call(player:, indicator:)
    last_five_matches_by_team_scope =
      MatchPlayerIndicator
        .joins(:player)
        .where(players: { team_id: player.team_id })
        .group('match_player_indicators.id')
        .order(created_at: :desc)
        .limit(5)
        .select('match_player_indicators.id')

    MatchPlayerIndicator
      .joins(:player)
      .where(player_id: player.id, indicator_id: indicator.id)
      .where(id: last_five_matches_by_team_scope).exists?
  end
end
