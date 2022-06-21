FactoryBot.define do
  factory :user do
    first_name { "Khin" }
    last_name { "Cho Oo" }
    # email { "khinchooo@gmail.com" }
    sequence(:email) { |n| "khinchooo#{n}@gamil.com" }
    password { "khin1234" }
  end
end
