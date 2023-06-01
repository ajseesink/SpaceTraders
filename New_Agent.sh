#!/bin/bash
#
#https://spacetraders.io/

echo "Enter Agent name: "
read AgentName
   
case $AgentName
in
   "" )   echo "null value not allowed" 
          exit 1;;
   *) echo "Agent's name is $AgentName" 
      echo "checking availability" ;;
esac

curl --silent --request POST  \
  --url 'https://api.spacetraders.io/v2/register' \
  --header 'Content-Type: application/json' \
  --data "{ \"symbol\": \"$AgentName\", \"faction\": \"COSMIC\"}" > New_Agent.json


ReturnCode=$(jq '.[] |.code' New_Agent.json)
ReturnError=$(jq '.error.data.symbol[0]' New_Agent.json)

if [ $ReturnCode == "422" ]
then
  echo "Something went wrong"
  echo "$ReturnError" 
  exit 1
else 
  echo "Agent $AgentName created" 
fi




#Get Token
#Use '-r' to het raw data, so without quotes
#
Token=$(jq -r '.[] |.token'  New_Agent.json)
echo $Token > Token.txt

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

