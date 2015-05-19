# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  owner_id   :integer          not null
#  status     :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Goal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
