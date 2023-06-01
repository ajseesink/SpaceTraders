#!/bin/bash

Token=(`cat Token.txt`)

curl --silent 'https://api.spacetraders.io/v2/my/agent' \
 --header "Authorization: Bearer $Token" > Start_Location.json


# Fetch fields
Agent=$(jq -r '.[] |.symbol' Start_Location.json)
HeadQuarter=$(jq -r '.[] |.headquarters' Start_Location.json)
Credits=$(jq -r '.[] |.credits' Start_Location.json)
Faction=$(jq -r '.[] |.startingFaction' Start_Location.json)

echo "Hello $Agent"
echo "You're at $HeadQuarter"
echo "You're Faction is $Faction"
echo "You have $Credits credits left"
