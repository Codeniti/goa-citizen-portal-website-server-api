FactoryGirl.define do
  factory :comment, :class => Comment do
    user
    issue
    description "Im so terrified yo!"
  end
end