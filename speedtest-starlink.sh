#!/bin/bash

OUTPUT_FILE="/var/www/starlink/starlink-jp"
TMP_FILE="/tmp/speedtest.tmp"

trap 'rm -f "$TMP_FILE"' EXIT

{
  echo "###########################################"
  echo "# これは日本リージョンからの"
  echo "# Starlinkのspeedtest-cliのテスト結果です。"
  echo "# Plan: ホームLite"
  echo "# \$ speedtest-cli --secure --simple"
  echo "###########################################"
  echo "-------------------------------------------"
  date
  /usr/bin/speedtest-cli --secure --simple
} > "$TMP_FILE"

if [ -f "$OUTPUT_FILE" ]; then
    awk 'NR>6' "$OUTPUT_FILE" >> "$TMP_FILE"
fi

mv "$TMP_FILE" "$OUTPUT_FILE"

