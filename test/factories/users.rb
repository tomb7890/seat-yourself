FactoryBot.define do
  factory :restaurant_goer, class: "User"  do
    name { Faker::Name.name }
    email { "#{name.gsub(/[^0-9a-zA-Z]/i, '')}@example.com" }
    password { "password" }
    password_confirmation { "password" } 
  end
end
