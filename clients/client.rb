#!/bin/ruby

# This file is like client.sh, but in ruby

require 'rest_client'
require 'json'

response = RestClient.get 'http://localhost/tickets.json'  # Read all tickets
print response, "\n"

# Insert a new ticket
response = RestClient.post "http://localhost/tickets/",
    { "name"=> "Juan", "surname"=> "Gonzalez", "email"=> "jglez@gmail.com", "seat"=> 199, "address"=> "Calle 1\n08001\nBarcelona" }.to_json,
    :content_type => :json,
    :accept => :json
print response


