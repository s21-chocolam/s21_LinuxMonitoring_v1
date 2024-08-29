#!/bin/bash

#1 - white:  \033[97m	\033[107m
#2 - red: \033[91m	\033[101m
#3 - green: \033[92m	\033[102m
#4 - blue: \033[94m	\033[104m
#5 – purple: \033[95m	\033[105m
#6 - black: \033[30m	\033[40m
. ./options.sh

background=(0 "\033[107m" "\033[101m" "\033[102m" "\033[104m" "\033[105m" "\033[40m")
fonts=(0 "\033[97m" "\033[91m" "\033[92m" "\033[94m" "\033[95m" "\033[30m")
value=(0 0 0 0 0)

if [ "$#" -eq 4 ]; then
  if [[ $1 == $2 || $3 == $4 ]]; then
    echo "Цвет фона и шрифт не должны совпадать"
    exit 1
  else
    for (( i = 1; i <= $#; i++ )); do
      parameters=${!i}
      # echo $parameters
      if [[ ${parameters} -ge 1 && ${parameters} -le 6 ]]; then
        if (( i % 2 == 0 )); then
          value[i]="${background[$parameters]}"
          # echo ${value[i]} 1
        else
          value[i]="${fonts[$parameters]}"
          # echo ${value[i]} 2
        fi
      else
        echo "Неправильный параметр {$i}, введите числа от 1 до 6 включительно"
        exit 1
      fi
    done
    FIRST="${value[1]}${value[2]}"
    SECOND="${value[3]}${value[4]}"
    # echo ${FIRST}
    # echo ${SECOND}

    echo -e "${FIRST}HOSTNAME\033[0m = ${SECOND}$HOSTNAME\033[0m"
    echo -e "${FIRST}TIMEZONE\033[0m = ${SECOND}$TIMEZONE\033[0m"
    echo -e "${FIRST}USER\033[0m = ${SECOND}$USER\033[0m"
    echo -e "${FIRST}OS\033[0m = ${SECOND}$OS\033[0m"
    echo -e "${FIRST}DATE\033[0m =${SECOND}$DATE\033[0m"
    echo -e "${FIRST}UPTIME\033[0m =${SECOND}$UPTIME\033[0m"
    echo -e "${FIRST}UPTIME_SEC\033[0m = ${SECOND}$UPTIME_SEC\033[0m"
    echo -e "${FIRST}IP\033[0m = ${SECOND}$IP\033[0m"
    echo -e "${FIRST}MASK\033[0m = ${SECOND}$MASK\033[0m"
    echo -e "${FIRST}GATEWAY\033[0m = ${SECOND}$GATEWAY\033[0m"
    echo -e "${FIRST}RAM_TOTAL\033[0m = ${SECOND}$RAM_TOTAL\033[0m"
    echo -e "${FIRST}RAM_USED\033[0m = ${SECOND}$RAM_USED\033[0m"
    echo -e "${FIRST}RAM_FREE\033[0m = ${SECOND}$RAM_FREE\033[0m"
    echo -e "${FIRST}SPACE_ROOT\033[0m = ${SECOND}$SPACE_ROOT\033[0m"
    echo -e "${FIRST}SPACE_ROOT_USED\033[0m = ${SECOND}$SPACE_ROOT_USED\033[0m"
    echo -e "${FIRST}SPACE_ROOT_FREE\033[0m = ${SECOND}$SPACE_ROOT_FREE\033[0m"
  fi
else
  echo "Количество параметров должно быть равно 4"
fi