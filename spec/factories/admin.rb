FactoryBot.define do
  factory :user_admin, class: User do
    name { "admin" }
    email { "admin@admin.com" }
    password { "password" }
    admin { true }
  end
end