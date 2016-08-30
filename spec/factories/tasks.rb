FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    completed false
    sequence(:priority) { |n| n - 1 }
    trait :empty_priority do
      priority nil
    end
    deadline { Time.now }
    project { FactoryGirl.create(:project) }
    after(:create) do |task|
      task.comments << FactoryGirl.create(:comment)
    end
  end
end
