require 'rails_helper'

RSpec.describe Game, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  rows       :integer
#  cols       :integer
#  mines      :integer
#  state      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
