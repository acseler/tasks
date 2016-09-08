FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "fake#{n}@fake.com" }
    password '12345678'
    password_confirmation '12345678'

    factory :confirmed_user do
      confirmed_at Time.zone.now
    end

    after(:create) do |user|
      user.projects << FactoryGirl.create(:project)
    end
  end
end