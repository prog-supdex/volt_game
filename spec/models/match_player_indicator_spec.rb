require 'rails_helper'

RSpec.describe MatchPlayerIndicator, type: :model do
  let(:match_player) { create(:match_player) }
  let(:indicator) { create(:indicator) }
  let!(:match_player_indicator) { create(:match_player_indicator, indicator: indicator, match_player: match_player) }

  it { is_expected.to belong_to(:match_player) }
  it { is_expected.to belong_to(:indicator) }
  it { is_expected.to have_db_index(%i[match_player_id indicator_id]) }
  it { expect{ described_class.create(match_player: match_player, indicator: indicator) }.to raise_error(ActiveRecord::RecordNotUnique) }
end
