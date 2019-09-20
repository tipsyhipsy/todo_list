FactoryBot.define do
  factory :user, class: User do
    name { 'foo' }
    email { 'foo@foo.com' }
    password { 'password' }
    admin { false }
  end

  factory :user_other, class: User do
    name { "baa" }
    email { "baa@baa.com" }
    password { "password" }
    admin { false }
  end

  factory :user_unique, class: User do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n|"email#{n}@test.com" }
    password { "password" }
    admin { false }
  end
end
