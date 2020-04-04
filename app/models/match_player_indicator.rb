# == Schema Information
#
# Table name: match_player_indicators
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  indicator_id    :bigint           not null
#  match_player_id :bigint           not null
#
# Indexes
#
#  index_match_player_indicators_on_indicator_id      (indicator_id)
#  index_match_player_indicators_on_match_player_id   (match_player_id)
#  unq_idx_m_p_i_on_match_player_id_and_indicator_id  (match_player_id,indicator_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (indicator_id => indicators.id)
#  fk_rails_...  (match_player_id => match_players.id)
#
class MatchPlayerIndicator < ApplicationRecord
  belongs_to :match_player
  belongs_to :indicator
end
