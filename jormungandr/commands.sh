RESTORE='\033[0m'

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'

LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

source .env

export PATH="$PATH:$PWD"

function start() {
  if [ ! -f "node-secret.yaml" ]; then
    echo "booting jormungandr"
    screen -A -m -d -S jormungandr ./jormungandr --config config.yaml --rest-listen 127.0.0.1:"${REST_PORT}" --genesis-block-hash "${GENESIS_HASH}" &
  else
    echo "booting jormungandr in leader mode"
    screen -A -m -d -S jormungandr ./jormungandr --config config.yaml --secret node-secret.yaml --rest-listen 127.0.0.1:"${REST_PORT}" --genesis-block-hash "${GENESIS_HASH}" &
  fi

}


function stop() {
    echo "$(jcli rest v0 shutdown get -h http://127.0.0.1:${REST_PORT}/api)"
}


function stats() {

  echo $(jcli rest v0 node stats get -h http://127.0.0.1:${REST_PORT}/api)
  echo $(jcli rest v0 account get ${ADDRESS} -h  http://127.0.0.1:${REST_PORT}/api)
  echo $(jcli rest v0 leaders logs get -h http://127.0.0.1:${REST_PORT}/api)
  echo $(jcli rest v0 stake-pool get ${STAKE_POOL_ID} -h http://127.0.0.1:${REST_PORT}/api)


}

function nodes() {
    nodes="$(netstat -tupan | grep jor | grep EST | cut -c 1-80)"
    total="$(netstat -tupan | grep jor | grep EST | cut -c 1-80 | wc -l)"
    printf "%s\n" "${nodes}" "----------" "Total:" "${total}"
}