FactoryGirl.define do
  factory :answer do
    sequence(:body) { |n| "Answer #{n} body text..." }
    question
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    question
  end
end
