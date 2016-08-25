FactoryGirl.define do
  factory :question do
    sequence(:title) { |n| "Question #{n} title text..." }
    sequence(:body) { |n| "Question #{n} body text..." }
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end
end
