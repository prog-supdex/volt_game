module MatchPlayerIndicators::AddIndicatorToPlayerService
  def self.call(match_id:, player_id:, indicator_id:)
    match_player = MatchPlayer.find_by!(match_id: match_id, player_id: player_id)

    match_player.match_player_indicators.create!(indicator_id: indicator_id)
  end
end
