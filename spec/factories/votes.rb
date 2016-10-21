FactoryGirl.define do
  factory :vote do
    rating 0
    user
    votable
  end
end
