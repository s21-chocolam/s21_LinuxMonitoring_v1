#!/bin/bash

. ../03/options.sh

background=(0 "\033[107m" "\033[101m" "\033[102m" "\033[104m" "\033[105m" "\033[40m")
fonts=(0 "\033[97m" "\033[91m" "\033[92m" "\033[94m" "\033[95m" "\033[30m")
numbers=(0 0 0 0 0) #пришедшие значения
value=(0 0 0 0 0) #корректные значения (default заменяется на число из default_colors)
colors=(0 "white" "red" "green" "blue" "purple" "black")
default_colors=(0 6 1 2 4) #цвета для default
correct_value=(0 0 0 0 0) #сюда записываются номера фонов и шрифтов

if [ "$(wc -w numbers.conf | awk '{print $1}')" -eq 4 ]; then
  numbers=($(cat numbers.conf))
  for (( i = 1; i <=4; i++)); do
    if [[ ${numbers[i-1]} -ge 1 && ${numbers[i-1]} -le 6 ]]; then
      value[i]=${numbers[i-1]}
    elif [[ "${numbers[i-1]}" == "default" ]]; then
      value[i]=${default_colors[i]}
    else
      echo "Неправильный параметр $i, введите числа от 1 до 6 включительно или default"
      exit 1
    fi
  done
else
  echo "Количество параметров должно быть равно 4"
  exit 1
fi

for (( i = 1; i <= 4; i++ )); do
  if (( i % 2 == 0 )); then
    correct_value[i]="${background[${value[i]}]}"
  else
    correct_value[i]="${fonts[${value[i]}]}"
  fi
done

FIRST="${correct_value[1]}${correct_value[2]}"
SECOND="${correct_value[3]}${correct_value[4]}"

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
echo ""

for (( i = 1; i <=4; i++ )); do
  if (( i % 2 == 0 )); then 
    echo "Column 1 font color = ${numbers[i-1]} (${colors[${value[i]}]})"
  else
    echo "Column 1 background = ${numbers[i-1]} (${colors[${value[i]}]})"
  fi
done