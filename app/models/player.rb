class Player < ApplicationRecord
  belongs_to :team
  has_many :match_player_indicators

  validates :name, presence: true

  def exists_indicator_in_last_matches?(indicator)
    match_player_indicators.exists_indicator_in_last_matches?(indicator)
  end

  def complete_indicator_in_match!(indicator:, match:)
    match_player_indicators.create(player: self, indicator: indicator, match: match)
  end
end
