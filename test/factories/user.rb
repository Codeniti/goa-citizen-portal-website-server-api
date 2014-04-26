FactoryGirl.define do
  factory :user, :class => User do
    email "rajdeep-#{SecureRandom.hex}@vacationlabs.com"
    password "123456"
    password_confirmation { password }
  end
end