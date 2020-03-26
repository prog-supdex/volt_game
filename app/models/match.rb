# == Schema Information
#
# Table name: matches
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Match < ApplicationRecord
  has_many :match_player_indicators, dependent: :destroy
  has_many :players, through: :match_player_indicators

  validates :name, presence: true
end
