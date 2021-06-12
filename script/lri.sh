#!/usr/bin/env bash

luarocks --lua-version 5.4 --tree ~/Git/hs-config/.rocks install --no-doc --force "$1"
