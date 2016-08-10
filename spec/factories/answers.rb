FactoryGirl.define do
  factory :answer do
    question_id 1
    body "MyText"
    association :question
  end
end
