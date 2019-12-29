#!/bin/bash

source .env

TIP=$(./jcli rest v0 node stats get --output-format json -h http://127.0.0.1:${REST_PORT}/api | jq -r .lastBlockHeight)

curl -G "https://api.pooltool.io/v0/sharemytip?poolid=${STAKE_POOL_ID}&userid=${PT_USER_ID}&genesispref=8e4d2a343f3dcf93&mytip=${TIP}"