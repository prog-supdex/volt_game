require 'rails_helper'

RSpec.describe MatchPlayerIndicator, type: :model do
  it { is_expected.to belong_to(:match) }
  it { is_expected.to belong_to(:player) }
  it { is_expected.to belong_to(:indicator) }
  it { is_expected.to have_db_index(%i[match_id player_id indicator_id]) }
end
