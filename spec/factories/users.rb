FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    image { 'base64 image' }
  end
end
