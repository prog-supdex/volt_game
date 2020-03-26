require 'rails_helper'

describe Players::ExistsPlayerWithIndicatorInLastMatchesService do
  let(:indicator) { create(:indicator) }
  let(:team_one) { create(:team) }
  let(:player) { create(:player, team: team_one) }
  let(:player_two) { create(:player, team: team_one) }
  let(:player_three) { create(:player, team: team_one) }
  let(:player_four) { create(:player, team: team_one) }
  let(:player_five) { create(:player, team: team_one) }

  let(:match) { create(:match) }
  let(:match_two) { create(:match) }

  describe '.call' do
    before do
      create_list(:match_player_indicator, 2, match: match, player: player)
      create_list(:match_player_indicator, 2, match: match, player: player_two)
      create_list(:match_player_indicator, 2, match: match_two, player: player_three)
      create_list(:match_player_indicator, 2, match: match_two, player: player_four)
      create_list(:match_player_indicator, 2, player: player_five)
      create_list(:match_player_indicator, 10)
    end

    it 'returns false' do
      expect(described_class.call(indicator: indicator, player: player)).to eq(false)
    end

    it 'returns true' do
      create(:match_player_indicator, match: match, indicator: indicator, player: player)
      create_list(:match_player_indicator, 2, player: player_five)

      expect(player.exists_indicator_in_last_matches?(indicator)).to eq(true)
    end
  end
end