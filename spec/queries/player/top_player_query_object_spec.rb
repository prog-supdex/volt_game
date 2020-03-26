require 'rails_helper'
#require './app/services/paid_options/handlers/catalog_banner.rb'

describe Player::TopPlayersQueryObject do
  let(:indicator) { create(:indicator) }

  let(:team_one) { create(:team) }
  let(:team_two) { create(:team) }

  let(:player) { create(:player, team: team_one) }
  let(:player_two) { create(:player, team: team_two) }
  let(:player_three) { create(:player, team: team_two) }

  describe '#call' do
    before do
      create_list(:match_player_indicator, 5, indicator: indicator)
      create_list(:match_player_indicator, 4, player: player, indicator: indicator)
      create_list(:match_player_indicator, 3, player: player_two, indicator: indicator)
      create_list(:match_player_indicator, 2, player: player_three, indicator: indicator)
    end

    it 'returns top 5 players by all teams' do
      top_five_players = described_class.call(indicator: indicator)

      expect(top_five_players.to_a.size).to eq(5)
      expect(top_five_players.first).to eq(player)
      expect(top_five_players.second).to eq(player_two)
      expect(top_five_players.third).to eq(player_three)
    end

    it 'returns top 5 players by team' do
      3.times do
        create(:match_player_indicator, player: create(:player, team: team_two), indicator: indicator)
      end

      top_five_players = described_class.call(indicator: indicator, team: team_two)

      expect(top_five_players.to_a.size).to eq(5)
      expect(top_five_players.first).to eq(player_two)
      expect(top_five_players.second).to eq(player_three)
    end
  end
end
