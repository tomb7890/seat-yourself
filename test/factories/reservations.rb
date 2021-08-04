FactoryBot.define do
  factory :reservation do
    partysize {  4 } 
    start_time { DateTime.new(2021, 8, 4, 14) }
    restaurant
    user
  end
end 
