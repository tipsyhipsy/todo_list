FactoryBot.define do
  factory :label do
    name { "test1" }
    id { 1 }
  end

  factory :label_second, class: Label do
    name { "test2" }
    id { 2 }
  end

  factory :label_third, class: Label do
    name { "test3" }
    id { 3 }
  end

end
