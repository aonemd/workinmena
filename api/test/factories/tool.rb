FactoryBot.define do
  factory :tool do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    website { 'https://language.com' }
  end
end

