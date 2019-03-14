FactoryBot.define do
  factory :company do
    name { Faker::Name.name }
    website { Faker::Internet.url }
  end
end
