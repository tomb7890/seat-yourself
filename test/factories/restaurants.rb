FactoryBot.define do

  factory :user do
    name { "Bob Franks" }
    email { "bob@franks.com" }
    password { "sekret" } 
  end
  
  factory :restaurant do
    owner { association :user }
    
    name { "Canoe" } 
    seating_capacity { 100 }
    open_hour { 11 }  # 11am
    close_hour { 21 } # 9pm
  end
end
