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

FactoryGirl.define do
  factory :goal do
    content { Faker::Hacker.say_something_smart }
    owner_id 1
    status { %w(public private).sample }
    title { Faker::Hacker.noun.capitalize }

    factory :goal_public do
      status "public"
      title "Public Goal"
    end

    factory :goal_private do
      status "private"
      title "Private Goal"
    end

    factory :goal_pizza do
      content "Eat more pizza"
      owner_id 1
      status "private"
      title "Pizza"
    end

  end


end
