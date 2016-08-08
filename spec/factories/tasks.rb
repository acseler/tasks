FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    completed { [true, false].sample }
    project { FactoryGirl.create(:project) }
  end
end
