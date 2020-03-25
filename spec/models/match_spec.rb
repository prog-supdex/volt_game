require 'rails_helper'

RSpec.describe Match, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:match_player_indicators) }
  it { is_expected.to have_many(:players).through(:match_player_indicators) }
end
