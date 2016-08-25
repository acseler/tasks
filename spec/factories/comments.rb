FactoryGirl.define do
  factory :comment do
    message { FFaker::CheesyLingo.sentence }
  end
end
