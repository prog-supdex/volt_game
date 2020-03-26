require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:indicator) { create(:indicator) }
  let(:team_one) { create(:team) }
  let(:player) { create(:player, team: team_one) }
  let(:match) { create(:match) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:team) }
  it { is_expected.to have_many(:match_player_indicators) }

  describe '#exists_indicator_in_last_matches?' do
    before do
      create_list(:match_player_indicator, 5)
    end

    it 'returns false' do
      expect(player.exists_indicator_in_last_matches?(indicator)).to eq(false)
    end

    it 'return true' do
      create(:match_player_indicator, match: match, indicator: indicator, player: player)
      expect(player.exists_indicator_in_last_matches?(indicator)).to eq(true)
    end
  end
end
