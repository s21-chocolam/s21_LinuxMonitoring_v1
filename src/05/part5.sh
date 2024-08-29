#!/bin/bash

START=$(date +%s%N)

if [[ "$#" -eq 1 ]]; then
  if [[ "${1: -1}" == "/" ]]; then
    echo "Есть слеш в конце"
    if cd $1 &> /dev/null; then
      echo "Это путь"
      folders=$(ls -lR | grep "^d" | wc -l)
      big_folders=$(du -h | sort -nrk1 | awk 'FNR>1 {print $2}' | head -n 5 | sed ':a; N; $!ba; s/\n/, /g')
      files=$(ls -laR | grep "^-" | wc -l) # в том числе скрытые

      confs=$(find . -maxdepth 1 -type f -name '*.conf' | wc -l)
      texts=$(find . -maxdepth 1 -type f -name '*.txt' | wc -l)
      executables=$(find . -maxdepth 1 -type f -executable | wc -l)
      logs=$(find . -maxdepth 1 -type f -name '*.log' | wc -l)
      archives=$(find . -maxdepth 1 -type f \( -name '*.zip' -o -name '*.tar' -o -name '*.gz' -o -name '*.bz2' \) | wc -l)
      symlinks=$(find . -maxdepth 1 -type l | wc -l)

      big_files=$(find . -type f -exec du -h {} + | sort -hr | awk '{print $2}' | head -n 10 | sed ':a; N; $!ba; s/\n/, /g')
      # exec выполняет команду du для найденных файлов
      big_executable_files=$(find . -type f -executable -exec du -h {} + | sort -hr | awk '{print $2}' | head -n 10 | sed ':a; N; $!ba; s/\n/, /g')

      echo "Количество папок, включая подпапки: $folders"
      echo "5 папок с наибольшим размером в порядке убывания: $big_folders"
      echo "Общее число файлов: $files"
      echo -e "\nЧисло конфигурационных файлов (с расширением .conf): $confs\nтекстовых файлов: $texts\nисполняемых файлов: $executables\nлогов (файлов с расширением .log): $logs\nархивов: $archives\nсимволических ссылок: $symlinks\n"
      echo -e "Топ 10 файлов с самым большим весом в порядке убывания (путь, размер и тип):\n$big_files\n"
      echo -e "Топ 10 исполняемых файлов с самым большим весом в порядке убывания (путь, размер и тип):\n$big_executable_files"
      END=$(date +%s%N)
      DIFF=$((($END - $START)/1000000))
      echo "Время работы скрипта: $DIFF ms"

    else
      echo "Несуществующая директория"
      exit 1
    fi
  else
    echo "Нет слеша в конце"
    exit 1
  fi
else
  echo "Параметр должен быть один"
  exit 1
fi