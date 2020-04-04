class CreateMatchPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :match_players do |t|
      t.references :match, foreign_key: true, null: false
      t.references :player, foreign_key: true, null: false

      t.timestamps
    end
  end
end
