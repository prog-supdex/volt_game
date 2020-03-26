# == Schema Information
#
# Table name: match_player_indicators
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  indicator_id :bigint
#  match_id     :bigint           not null
#  player_id    :bigint           not null
#
# Indexes
#
#  index_match_player_indicators_on_indicator_id             (indicator_id)
#  index_match_player_indicators_on_match_id                 (match_id)
#  index_match_player_indicators_on_player_id                (player_id)
#  unq_idx_m_p_i_on_player_id_and_indicator_id_and_match_id  (match_id,player_id,indicator_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (indicator_id => indicators.id)
#  fk_rails_...  (match_id => matches.id)
#  fk_rails_...  (player_id => players.id)
#
class MatchPlayerIndicator < ApplicationRecord
  belongs_to :match
  belongs_to :player
  belongs_to :indicator, optional: true

  def self.exists_indicator_in_last_matches?(indicator)
    where(indicator: indicator).limit(5).order(created_at: :desc).exists?
  end
end
