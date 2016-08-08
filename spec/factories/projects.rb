FactoryGirl.define do
  factory :project do
    sequence(:title) { |n| "Project #{n}" }
    user { FactoryGirl.create(:user) }
  end
end
