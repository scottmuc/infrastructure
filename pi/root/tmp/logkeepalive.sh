#!/usr/bin/env bash

KEEP_ALIVE_TIMER=25

while true; do
  read -t "${KEEP_ALIVE_TIMER}" buf
  if [[ "${buf}" = "" ]]; then
    logger "logkeepalive.sh: haven't read a log in ${KEEP_ALIVE_TIMER}s, staying alive"
  fi
done

