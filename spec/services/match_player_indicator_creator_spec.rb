require 'rails_helper'

describe MatchPlayerIndicatorCreator do
  let(:player) { create(:player) }
  let(:match) { create(:match) }
  let(:indicator) { create(:indicator) }

  describe '.call' do
    it 'creates match_player_indicator' do
      expect { described_class.call(match: match, indicator: indicator, player: player) }
        .to change { MatchPlayerIndicator.count }.by(1)
    end

    it 'updates match_player_indicator' do
      described_class.call(match: match, player: player)

      expect { described_class.call(match: match, player: player, indicator: indicator) }
        .to_not change(MatchPlayerIndicator, :count)

      expect(MatchPlayerIndicator.last.indicator).to eq(indicator)
    end
  end
end
