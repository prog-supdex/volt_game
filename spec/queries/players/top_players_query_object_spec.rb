require 'rails_helper'

describe Players::TopPlayersQueryObject do
  let(:indicator) { create(:indicator) }

  let(:team_one) { create(:team) }
  let(:team_two) { create(:team) }

  let(:match) { create(:match) }
  let(:match_two) { create(:match) }
  let(:match_three) { create(:match) }

  let(:player) { create(:player, team: team_one) }
  let(:player_two) { create(:player, team: team_two) }
  let(:player_three) { create(:player, team: team_two) }
  let(:player_four) { create(:player, team: team_two) }

  let(:match_player_one) { create(:match_player, player: player, match: match) }
  let(:match_player_two) { create(:match_player, player: player_two, match: match) }
  let(:match_player_three) { create(:match_player, player: player_three, match: match) }

  describe '#call' do
    before do
      create_list(:match_player_indicator, 2, indicator: indicator)

      4.times do
        create(:match_player_indicator, match_player: create(:match_player, player: player), indicator: indicator)
      end

      3.times do
        create(:match_player_indicator, match_player: create(:match_player, player: player_two), indicator: indicator)
      end

      2.times do
        create(:match_player_indicator, match_player: create(:match_player, player: player_three), indicator: indicator)
      end
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
        create(:match_player_indicator, match_player: create(:match_player, player: create(:player, team: team_two)), indicator: indicator)
      end

      top_five_players = described_class.call(indicator: indicator, team: team_two)

      expect(top_five_players.to_a.size).to eq(5)
      expect(top_five_players.first).to eq(player_two)
      expect(top_five_players.second).to eq(player_three)
    end
  end
end
