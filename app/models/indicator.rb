# == Schema Information
#
# Table name: indicators
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Indicator < ApplicationRecord
  validates :name, presence: true
end
