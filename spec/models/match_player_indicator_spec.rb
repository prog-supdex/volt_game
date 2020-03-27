require 'rails_helper'

RSpec.describe MatchPlayerIndicator, type: :model do
  let(:player) { create(:player) }
  let(:match) { create(:match) }
  let(:indicator) { create(:indicator) }
  let!(:match_player_indicator) { create(:match_player_indicator, indicator: indicator, match: match, player: player) }

  it { is_expected.to belong_to(:match) }
  it { is_expected.to belong_to(:player) }
  it { is_expected.to belong_to(:indicator).optional }
  it { is_expected.to have_db_index(%i[match_id player_id indicator_id]) }
  it { expect{ described_class.create(match: match, player: player, indicator: indicator) }.to raise_error(ActiveRecord::RecordNotUnique) }
end
