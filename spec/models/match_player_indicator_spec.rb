require 'rails_helper'

RSpec.describe MatchPlayerIndicator, type: :model do
  let(:indicator) { create(:indicator) }
  let(:indicator_two) { create(:indicator) }

  it { is_expected.to belong_to(:match) }
  it { is_expected.to belong_to(:player) }
  it { is_expected.to belong_to(:indicator).optional }
  it { is_expected.to have_db_index(%i[match_id player_id indicator_id]) }

  describe '.exists_indicator_in_last_matches?' do
    before do
      create_list(:match_player_indicator, 5, indicator: indicator)
    end

    it 'is true' do
      create(:match_player_indicator, indicator: indicator_two)

      expect(described_class.exists_indicator_in_last_matches?(indicator_two)).to be(true)
    end

    it 'is false' do
      expect(described_class.exists_indicator_in_last_matches?(indicator_two)).to be(false)
    end
  end
end
