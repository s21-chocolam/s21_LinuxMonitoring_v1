#!/bin/bash

DATA=$(./options.sh)
echo "$DATA"

read -p "Записать данные в файл? [Y/N]   " answer

DATE=$(date +%x | sed s/[.]/_/g)
TIME=$(date +%T | sed s/[:]/_/g)
FILE="${DATE}_${TIME}.status"

if [[ $answer == "y" || $answer == "Y" ]]; then
  echo "$DATA" > "$FILE"
else
  echo "Данные не были записаны в файл"
fi