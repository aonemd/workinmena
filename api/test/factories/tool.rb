FactoryBot.define do
  factory :tool do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    website { Faker::Internet.url }
  end
end

