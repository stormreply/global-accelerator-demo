#!/bin/bash

GLOBAL_ACCELERATOR_URL=$1
NUMBER_CURL_CALLS=${2:-40}

(
  trap 'exit 0' INT
  i=0
  while [ $i -lt $NUMBER_CURL_CALLS ] ; do
    curl -s "$GLOBAL_ACCELERATOR_URL" \
    | grep Instance \
    | sed -e 's/^.*<h2>\(.*\)<\/h2>.*$/\1/g'
    sleep 0.1
    i=$((i + 1))
  done
) | tee test.data

echo

cat test.data | awk '
  {
    s[$0]+=1
    n+=1
  }

  END {
    for (i in s) {
      printf("%4.1f%% %3d   %s\n", 100*s[i]/n, s[i], i)
    }
  }
' | sort -nr -k2
