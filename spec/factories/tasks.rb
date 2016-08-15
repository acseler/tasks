FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    completed false
    project { FactoryGirl.create(:project) }
  end
end
