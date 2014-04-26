FactoryGirl.define do
  factory :issue, :class => Issue do
    title "Super rad issue #{SecureRandom.uuid}"
    description "Super rad description #{SecureRandom.uuid}"
  end
end