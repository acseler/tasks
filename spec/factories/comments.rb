FactoryGirl.define do
  factory :comment do
    message { FFaker::CheesyLingo.sentence }
    after(:create) do |comment|
      comment.attachments << FactoryGirl.create(:attachment, comment: comment)
    end
  end
end
