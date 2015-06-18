
# Title: Findy
# Desc: Terminal app to find places to eat, park etc around GA Sydney. For BEWD4 Midterm.
# Author: Daniel Baker
# Version: 0.0.1

# Set up requirements
require 'json'
require 'rest-client'
require 'byebug'

# Set GA location latlng
location_lat = '-33.867487'
location_lng = '151.206990'
location = location_lat + ',' + location_lng

# Set order
rankby = 'distance'

# Set API key
api_key = 'AIzaSyBaK68kSyX2o_fMsbLYtxkcb6CpOkcMLMs'

def get_type(query)
  # Set places type
  type = query
  if type.size < 3
    puts 'Error, please use at least 3 characters'
  else
    type
  end
end



# Start app

puts 'What are you looking for? E.g Parking'

query = get_input
process_type = get_type(query)
pretty_type = pretty_input(query)

puts "Searching for #{pretty_type} near General Assembly"

# Build query URL from user inputs
def build_url(location, rankby, type, api_key)
  build_location = 'location=' + location
  build_rankby = '&rankby=' + rankby
  build_type = '&type=' + type
  build_api = '&key=' + api_key
  url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?' + build_location + build_rankby + build_type + build_api
end

# Put build_url into var url
url = build_url(location, rankby, process_type, api_key)

# Convert json data to hash
def build_place_hash(name,street)
  { :name => name, :street => street }
end

# Get response and process json data
def process_places(places, url)
  data = RestClient::Request.execute(url: url, method: :get, verify_ssl: false)
  json_data = JSON.parse(data)
  results = json_data['results']
  results.each do |place|
    # Specify data needed from json data
    place_hash = build_place_hash(place['name'],place['vicinity'])
    places << place_hash
  end
end

# Show all places in order of distance
def show_places(places)
  places.each do |place|
    puts "Name: #{place[:name]}, Address: #{place[:street]}"
  end
end

places = []

process_places(places,url)

puts 'Results:'

show_places(places)



