module MatchPlayerIndicatorCreator
  def self.call(player:, indicator: nil, match:)
    MatchPlayerIndicator
      .find_or_initialize_by(player: player, match: match)
      .update_attribute(:indicator, indicator)
  end
end
