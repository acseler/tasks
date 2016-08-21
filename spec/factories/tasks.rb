FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    completed false
    sequence(:priority) { |n| n - 1 }
    trait :empty_priority do
      priority nil
    end
    project { FactoryGirl.create(:project) }
  end
end
