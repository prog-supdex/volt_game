class MatchPlayerIndicator < ApplicationRecord
  belongs_to :match
  belongs_to :player
  belongs_to :indicator

  def self.exists_indicator_in_last_matches?(indicator)
    where(indicator: indicator).limit(5).order(created_at: :desc).exists?
  end
end
