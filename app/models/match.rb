class Match < ApplicationRecord
  has_many :match_player_indicators, dependent: :destroy
  has_many :players, through: :match_player_indicators

  validates :name, presence: true
end
