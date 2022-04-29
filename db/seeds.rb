# coding: utf-8
require 'csv'

def maybe_create_database_records(table, index, user)
  current_csv_category = table[index]['﻿Category']

  r = Restaurant.find_by(phone: table[index]['Restaurant Phone'])
  if r.nil? 
    r = Restaurant.new({
                         name: table[index]['Restaurant Name'],
                         longitude: table[index]['Restaurant Longitude'],
                         latitude: table[index]['Restaurant Latitude'],
                         address: table[index]['Restaurant Address'],
                         phone: table[index]['Restaurant Phone'],
                         pricerange: table[index]['Restaurant Price Range'],
                         website: table[index]['Restaurant Website'],
                         user_id: user.id,

                         # just hard code the seating_capacity for now 
                         seating_capacity: 35 
                       })
  end
  # ensure category is in the db 
  c = Category.find_or_create_by(name: current_csv_category) 

  # apply it to current restaurant if need be 
  if r.categories.find_by(name: current_csv_category).nil?
    r.categories << c
  end

  # set open and close hours 
  r.open_hour =  9 + rand(2)
  r.close_hour = r.open_hour + rand(23 - r.open_hour)

  
  r.save
  r.yelpreviews.find_or_create_by(review: table[index]['Restaurant Yelp URL'])
end 

def load_data
  user = User.create!({
                        email: "jcpenny.shopper@example.com",
                        name: "Susie McDonald",
                        password: "pass",
                        password_confirmation: "pass"
                      }
                     )

  table = CSV.parse(File.read("data/trt_rest.csv"), headers: true)

  # take a random sample of 300 records 
  random_indices = (1..(table.size).to_i).to_a.shuffle.slice(0, (100).to_i )

  while not random_indices.empty?   
    index = random_indices.pop 
    unless table[index].nil?
      maybe_create_database_records(table, index, user)
    end 
  end
end


Reservation.destroy_all
Yelpreview.destroy_all
Restaurant.destroy_all
Category.destroy_all
User.destroy_all
load_data

