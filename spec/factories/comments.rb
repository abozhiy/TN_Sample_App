FactoryGirl.define do
  factory :comment do
    body "MyText"
    user_id 1
    commentable_id 1
    sequence(:commentable_type) { "question" || "answer" }
  end

  factory :invalid_comment, class: "Comment" do
    body nil
    user_id 2
    commentable_id 2
    commentable_type "string"
  end
end
