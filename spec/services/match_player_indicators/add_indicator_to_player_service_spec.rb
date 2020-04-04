require 'rails_helper'

describe MatchPlayerIndicators::AddIndicatorToPlayerService do
  let(:indicator) { create(:indicator) }
  let(:match_player) { create(:match_player) }

  it 'raises exception ActiveRecord::RecordNotUnique' do
    expect { described_class.call(match_id: 1, player_id: 1, indicator_id: indicator.id) }
     .to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'create match_player_indicators' do
    expect { described_class.call(match_id: match_player.match, player_id: match_player.player_id, indicator_id: indicator.id) }
      .to change(MatchPlayerIndicator, :count)
  end
end
