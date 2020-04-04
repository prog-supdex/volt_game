class ChangeColumnsMatchPlayersIndicators < ActiveRecord::Migration[5.2]
  def up
    remove_columns :match_player_indicators, :match_id, :player_id, :indicator_id

    add_reference(:match_player_indicators, :match_player, foreign_key: true, null: false)
    add_reference(:match_player_indicators, :indicator, foreign_key: true, null: false)

    add_index :match_player_indicators,
              %i[match_player_id indicator_id],
              unique: true,
              name: :unq_idx_m_p_i_on_match_player_id_and_indicator_id
  end

  def down
    remove_columns :match_player_indicators, :match_player_id, :indicator_id

    add_reference :match_player_indicators, :match, foreign_key: true, null: false
    add_reference :match_player_indicators, :player, foreign_key: true, null: false
    add_reference :match_player_indicators,:indicator, foreign_key: true, null: false

    add_index :match_player_indicators,
              %i[match_id player_id indicator_id],
              unique: true,
              name: :unq_idx_m_p_i_on_player_id_and_indicator_id_and_match_id
  end
end
