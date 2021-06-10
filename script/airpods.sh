#!/user/bin/env bash

# Manages bluetooth connectivity of AirPods

if [[ "$#" -ne 1 || ("$1" != "toggle" && "$1" != "status") ]]; then
  echo "Usage: airpods [toggle|status]"
  exit 1
fi

# `blueutil --paired` to show
NAME='NBN AirPods'
ID='38-ec-0d-58-93-7f' # MAC address

CMD='/opt/homebrew/bin/blueutil'

is_connected() {
  if [[ $(${CMD} --is-connected ${ID}) -eq 1 ]]; then
    return 0
  else
    return 1
  fi
}

if ! "${CMD}" --info "${ID}" &>/dev/null; then
  echo "AirPods mac address ${ID} is invalid"
fi

case $1 in
toggle)
  if ! is_connected; then
    echo 'connect'
    $CMD --connect "$ID" &>/dev/null 2>&1 &
  else
    echo 'disconnect'
    $CMD --disconnect "$ID" &>/dev/null 2>&1 &
  fi
  ;;

status)
  if is_connected &>/dev/null; then
    echo 'connected'
  else
    echo 'disconnected'
  fi
  ;;
esac
