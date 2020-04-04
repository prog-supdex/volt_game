require 'rails_helper'

RSpec.describe MatchPlayer, type: :model do
  it { is_expected.to belong_to(:match) }
  it { is_expected.to belong_to(:player) }
end
