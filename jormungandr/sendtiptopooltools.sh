#!/bin/bash

source .env

TIP=$(./jcli rest v0 tip get -h http://127.0.0.1:${REST_PORT}/api)

curl -G "https://api.pooltool.io/v0/sharemytip?poolid=${STAKE_POOL_ID}&userid=${PT_USER_ID}&genesispref=8e4d2a343f3dcf93&mytip=${TIP}"