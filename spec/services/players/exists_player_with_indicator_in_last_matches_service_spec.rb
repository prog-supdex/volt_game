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

  describe '.call' do
    before do
      create(:match_player_indicator, indicator: indicator, match_player: create(:match_player, player: player))
      create(:match_player_indicator, match_player: create(:match_player, player: player_two))
      create(:match_player_indicator, match_player: create(:match_player, player: player_three))
      create(:match_player_indicator, match_player: create(:match_player, player: player_four))
      create(:match_player_indicator, match_player: create(:match_player, player: player_five))
      create(:match_player_indicator, match_player: create(:match_player, player: player_five))
    end

    it 'returns false' do
      expect(described_class.call(indicator: indicator, player: player)).to eq(false)
    end

    it 'returns true' do
      create(:match_player_indicator, indicator: indicator, match_player: create(:match_player, player: player))
      create(:match_player_indicator, indicator: indicator, match_player: create(:match_player, player: player_five))

      expect(described_class.call(indicator: indicator, player: player)).to eq(true)
    end
  end
end
