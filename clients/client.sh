#!/bin/bash

# Get ticket #1
curl -v http://localhost:8000/tickets/1.json

# Insert ticket
curl -v -X POST -H 'Content-Type: application/json' \
 -d '{ "name": "Juan", "surname": "Gonzalez", "email": "jglez@gmail.com", "seat": 199, "address": "Calle 1\n08001\nBarcelona" }' http://localhost:8000/tickets

