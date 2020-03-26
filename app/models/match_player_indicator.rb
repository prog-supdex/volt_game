# == Schema Information
#
# Table name: match_player_indicators
#
#  id           :bigint           not null, primary key
#  match_id     :bigint           not null
#  player_id    :bigint           not null
#  indicator_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class MatchPlayerIndicator < ApplicationRecord
  belongs_to :match
  belongs_to :player
  belongs_to :indicator

  def self.exists_indicator_in_last_matches?(indicator)
    where(indicator: indicator).limit(5).order(created_at: :desc).exists?
  end
end
