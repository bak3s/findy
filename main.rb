
# Title: Findy
# Desc: Terminal app to find places to eat, park etc around GA Sydney. For BEWD4 Midterm.
# Author: Daniel Baker
# Version: 0.1.0

# Set up requirements
require 'json'
require 'rest-client'
# require 'byebug'

# Includes
require './request.rb'

def get_input
  user_input = gets.chomp
  user_input.downcase.tr(" ","_")
end

def pretty_input(query)
  query.upcase.tr("_"," ")
end

def get_type(query)
  # Set places type
  type = query
  # Set exit variable
  exit = 0
  # Set types array
  types_array = [
    'accounting', 'airport', 'amusement_park', 'aquarium', 'art_gallery', 'atm', 'bakery', 
    'bank', 'bar', 'beauty_salon', 'bicycle_store', 'book_store', 'bowling_alley', 'bus_station', 
    'cafe', 'campground', 'car_dealer', 'car_rental', 'car_repair', 'car_wash', 'casino', 
    'cemetery', 'church', 'city_hall', 'clothing_store', 'convenience_store', 'courthouse', 
    'dentist', 'department_store', 'doctor', 'electrician', 'electronics_store', 'embassy', 
    'establishment', 'finance', 'fire_station', 'florist', 'food', 'funeral_home', 'furniture_store', 
    'gas_station', 'general_contractor', 'grocery_or_supermarket', 'gym', 'hair_care', 'hardware_store', 
    'health', 'hindu_temple', 'home_goods_store', 'hospital', 'insurance_agency', 'jewelry_store', 
    'laundry', 'lawyer', 'library', 'liquor_store', 'local_government_office', 'locksmith', 'lodging', 
    'meal_delivery', 'meal_takeaway', 'mosque', 'movie_rental', 'movie_theater', 'moving_company', 
    'museum', 'night_club', 'painter', 'park', 'parking', 'pet_store', 'pharmacy', 'physiotherapist', 
    'place_of_worship', 'plumber', 'police', 'post_office', 'real_estate_agency', 'restaurant', 
    'roofing_contractor', 'rv_park', 'school', 'shoe_store', 'shopping_mall', 'spa', 'stadium', 
    'storage', 'store', 'subway_station', 'synagogue', 'taxi_stand', 'train_station', 'travel_agency', 
    'university', 'veterinary_care', 'zoo'
  ]
  # Error handling
  if type.size < 3
    puts 'Error, please use at least 3 characters'
    exit = 1
  elsif !types_array.include? type # Check query against type array
    puts 'This type does not exist for a full list visit...'
    exit = 1
  else
    type
  end

end

# Start app

puts 'What are you looking for? E.g Parking'

query = get_input
process_type = get_type(query)
pretty_type = pretty_input(query)

if process_type == 1
  # If exit = 1, stop app
  puts 'Please try again'
else
  puts "Searching for #{pretty_type} near General Assembly"
  # New request
  new_request = Request.new('-33.867487,151.206990','distance','AIzaSyBaK68kSyX2o_fMsbLYtxkcb6CpOkcMLMs')
  new_request.type = process_type
  # Build API call/url
  built_url = new_request.build_url(@location,@rankby,@type,@api_key)
  # Set results to array
  places = []

  processed = new_request.process_places(places,built_url)

  puts 'Results:'
  # Push results
  new_request.show_places(places)
end