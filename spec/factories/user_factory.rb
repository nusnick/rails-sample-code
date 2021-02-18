FactoryGirl.define do
  #Define factory for User model
  factory :user do
  	sequence(:email) {|n| "sample_email_#{n}@example.com" }
   	sequence(:full_name) {|n| "FullName #{n}" }
    password "12345678"
    password_confirmation "12345678"
    confirmed_at Time.now
    published true
  end
end