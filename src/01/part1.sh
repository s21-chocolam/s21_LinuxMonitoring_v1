#!/bin/bash

if [[ "$#" -gt 1 || "$1" =~ [0-9] ]]; then
  echo "Error parameters"
  exit 1
else
  echo "$1"
fi