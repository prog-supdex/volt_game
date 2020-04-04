class CreateMatchPlayerIndicators < ActiveRecord::Migration[5.2]
  def change
    create_table :match_player_indicators do |t|
      t.references :match, foreign_key: true, null: false
      t.references :player, foreign_key: true, null: false
      t.references :indicator, foreign_key: true, null: false

      t.timestamps
    end

    add_index :match_player_indicators,
              %i[match_id player_id indicator_id],
              unique: true,
              name: :unq_idx_m_p_i_on_player_id_and_indicator_id_and_match_id
  end
end
