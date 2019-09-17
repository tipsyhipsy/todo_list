FactoryBot.define do
  factory :user_first, class: User do
    name { "foo" }
    email { "foo@foo.com" }
    password { "password" }
    admin { false }
  end

  factory :user_second, class: User do
    name { "baa" }
    email { "baa@baa.com" }
    password { "password" }
    admin { false }
  end
end
