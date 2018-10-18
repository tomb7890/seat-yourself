namespace :restaurants do
  desc "Set longitude & latitude coordinates for all restaurants that need them"
  task :update_coordinates => :environment do
    restaurants = Restaurant.where(longitude: nil, latitude: nil)
    restaurants.each do |r|
      r.geocode
      if r.save
        puts "#{r.name} was updated"
      else
        puts "There was an error saving restaurant #{r.name} with ID #{r.id}. "
      end
    end
    
  end
  
end
