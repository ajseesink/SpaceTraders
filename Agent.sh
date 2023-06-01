#!/bin/bash
#https://spacetraders.io/

Agent=$(jq '.[] |.agent'  New_Agent.json)
echo $Agent > Agent.json

Contract=$(jq '.[] |.contract'  New_Agent.json)
echo $Contract > Contract.json

Faction=$(jq '.[] |.faction'  New_Agent.json)
echo $Faction > Faction.json

# SHIP INFO
# jq '.<info>' Ship.txt
# <info> can be 
# 	- crew
#	- fuel
#	- frame
#	- reactor
#	- engine
#	- modules
#	- mounts
#	- registration
#	- cargo
#
Ship=$(jq '.[] |.ship'  New_Agent.json)
echo $Ship > Ship.json

AgentName=$(jq -r '.|.symbol' Agent.json)
Waypoint=$(jq -r '.|.headquarters' Agent.json)
Credits=$(jq -r '.|.credits' Agent.json)

Sector=$(echo $Waypoint | cut -f1 -d-)
System=$(echo $Waypoint | cut -f2 -d-)
SectorSystem=$Sector-$System
URL=https://api.spacetraders.io/v2/systems/$SectorSystem/waypoints/$Waypoint

echo "Hello Agent $AgentName"
echo "You're currently at $Waypoint (sector: $Sector, system: $System) "
echo "you have $Credits credits"

curl --silent $URL --header "Authorization: Bearer $Token" > StartingWaypointLocation.json
