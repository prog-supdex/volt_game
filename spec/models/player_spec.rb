require 'rails_helper'

RSpec.describe Player, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:team) }
  it { is_expected.to have_many(:match_player_indicators) }
end
