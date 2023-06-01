#!/bin/bash
#

# Get token
Token=(`cat Token.txt`)

curl --silent 'https://api.spacetraders.io/v2/my/contracts' \
 --header "Authorization: Bearer $Token" > Contract.json

# Example JSON output you will get with 'jq '.' Contract.json
#{
#  "data": [
#    {
#      "id": "<some ID here>",
#      "factionSymbol": "COSMIC",
#      "type": "PROCUREMENT",
#      "terms": {
#        "deadline": "2023-06-07T07:35:40.197Z",
#        "payment": {
#          "onAccepted": 2112,
#          "onFulfilled": 8448
#        },
#        "deliver": [
#          {
#            "tradeSymbol": "SILVER_ORE",
#            "destinationSymbol": "X1-VS75-70500X",
#            "unitsRequired": 960,
#            "unitsFulfilled": 0
#          }
#        ]
#      },
#      "accepted": false,
#      "fulfilled": false,
#      "expiration": "2023-06-01T07:35:40.197Z",
#      "deadlineToAccept": "2023-06-01T07:35:40.197Z"
#    }
#  ],
#  "meta": {
#    "total": 1,
#    "page": 1,
#    "limit": 10
#  }
#}

# Fetch fields
ContractID=$(jq -r '.data[0].id' Contract.json)
TradeSymbol=$(jq -r '.data[0].terms.deliver[0].tradeSymbol' Contract.json)
Destination=$(jq -r '.data[0].terms.deliver[0].destinationSymbol' Contract.json)
UnitsRequired=$(jq -r '.data[0].terms.deliver[0].unitsRequired' Contract.json)
OnAccepted=$(jq '.data[0].terms.payment.onAccepted' Contract.json)
onFulfilled=$(jq '.data[0].terms.payment.onFulfilled' Contract.json)
Deadline=$(jq -r '.data[0].terms.deadline' Contract.json)
Accepted=$(jq -r '.data[0].accepted' Contract.json)


if [ $Accepted == "false" )
then
  echo "The following contract is available"
  echo " "
  echo "Contract ID: $ContractID "
  echo "$UnitsRequired units of $TradeSymbol needs to be delivered" 
  echo "Destination: $Destination"
  echo "Reward: on acceptence: $OnAccepted credits"
  echo "        on delivery: $onFulfilled credits" 
  echo " " 
  echo "Do you want to accept the contract? <Y/N>"

#  read Input
#  case $Input in
#	Y | y)
#  	  echo "Accepted" 
#          curl --silent --request POST \
#            --url 'https://api.spacetraders.io/v2/my/contracts/$ContractID/accept' \
#            --header "Authorization: Bearer $Token" > Accepted.json ;;
#	N | n)
#	   echo "Not Accepted" ;;
#	*)
#	  echo "wrong input" ;;
#  esac
fi


if [ "$Accepted" == "true" ]
then
  echo "Contract ID: $ContractID"
  echo "Status     : Accepted"
  echo "Deadline   : $Deadline" 
fi


