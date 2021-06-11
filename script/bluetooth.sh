#!/user/bin/env bash

# Manages bluetooth connectivity of AirPods

if [[ "$#" -ne 2 || ("$1" != "toggle" && "$1" != "status") ]]; then
  echo "Usage: bluetooth [toggle|status] 2"
  exit 1
fi

CMD='/opt/homebrew/bin/blueutil'

is_connected() {
  if [[ $(${CMD} --is-connected $1) -eq 1 ]]; then
    return 0
  else
    return 1
  fi
}

if ! "${CMD}" --info "$2" &>/dev/null; then
  echo "Invalid device ID: $2"
fi

case $1 in
toggle)
  if ! is_connected $2; then
    echo 'connect'
    $CMD --connect "$2" &>/dev/null 2>&1 &
  else
    echo 'disconnect'
    $CMD --disconnect "$2" &>/dev/null 2>&1 &
  fi
  ;;

status)
  if is_connected $2; then
    echo 'connected'
  else
    echo 'disconnected'
  fi
  ;;
esac
