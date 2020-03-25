class Player < ApplicationRecord
  belongs_to :team
  has_many :match_player_indicators

  validates :name, presence: true

  def self.top_five_players_by_indicator(indicator_id:, team_id: nil)
    scope =
      select('COUNT(indicator_id) AS cn_indicators, player_id')
        .joins(:match_player_indicators)
        .where(match_player_indicators: { indicator_id: indicator_id })
        .group('indicator_id, player_id')
        .order('cn_indicators DESC')
        .limit(5)

    return scope if team_id.blank?

    scope.where(players: { team_id: team_id })
  end

  def exists_indicator_in_last_5_matches?(indicator)
    match_player_indicators.exists_indicator_in_last_matches?(indicator)
  end

  def complete_indicator_in_match!(indicator:, match:)
    match_player_indicators.create(player: self, indicator: indicator, match: match)
  end
end
