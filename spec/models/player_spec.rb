require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:indicator) { create(:indicator) }
  let(:indicator_second) { create(:indicator) }

  let(:team_one) { create(:team) }
  let(:team_two) { create(:team) }

  let(:player) { create(:player, team: team_one) }
  let(:player_two) { create(:player, team: team_two) }
  let(:player_three) { create(:player, team: team_two) }

  let(:match) { create(:match) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:team) }
  it { is_expected.to have_many(:match_player_indicators) }

  it 'creates relation indicator to player' do
    expect { player.complete_indicator_in_match!(match: match, indicator: indicator) }
      .to change { MatchPlayerIndicator.count }.by(1)
  end

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

  describe '.top_five_players_by_indicator' do
    before do
      create_list(:match_player_indicator, 5, indicator: indicator)
      create_list(:match_player_indicator, 4, player: player, indicator: indicator)
      create_list(:match_player_indicator, 3, player: player_two, indicator: indicator)
      create_list(:match_player_indicator, 2, player: player_three, indicator: indicator)
    end

    it 'returns top 5 players by all teams' do
      top_five_players = described_class.top_five_players_by_indicator(indicator_id: indicator.id)

      expect(top_five_players.to_a.size).to eq(5)
      expect(top_five_players.first).to eq(player)
      expect(top_five_players.second).to eq(player_two)
      expect(top_five_players.third).to eq(player_three)
    end

    it 'returns top 5 players by team' do
      3.times do
        create(:match_player_indicator, player: create(:player, team: team_two), indicator: indicator)
      end

      top_five_players = described_class.top_five_players_by_indicator(indicator_id: indicator.id, team_id: team_two.id)

      expect(top_five_players.to_a.size).to eq(5)
      expect(top_five_players.first).to eq(player_two)
      expect(top_five_players.second).to eq(player_three)
    end
  end
end
