#!/bin/bash

OUTPUT_FILE="/var/www/starlink/starlink-jp"
TMP_FILE="/tmp/speedtest.tmp"
MAX_RETRIES=3
SLEEP_SECONDS=60

{
  echo "###########################################"
  echo "# これは日本リージョンからの"
  echo "# Starlinkのspeedtest-cliのテスト結果です。"
  echo "# Plan: ホームLite"
  echo "# \$ speedtest-cli --secure --simple"
  echo "###########################################"
  echo "-------------------------------------------"
  date
} > "$TMP_FILE"

attempt=1
while [ $attempt -le $MAX_RETRIES ]; do
    echo "speedtest-cli 実行: 試行 $attempt"
    
    OUTPUT=$( /usr/bin/speedtest-cli --secure --simple )
    
    if [ -n "$OUTPUT" ]; then
        echo "$OUTPUT" >> "$TMP_FILE"
        break
    else
        echo "結果が空です。$SLEEP_SECONDS 秒後にリトライします..."
        sleep $SLEEP_SECONDS
        attempt=$((attempt + 1))
    fi
done

if [ -f "$OUTPUT_FILE" ]; then
    awk 'NR>6' "$OUTPUT_FILE" >> "$TMP_FILE"
fi

mv "$TMP_FILE" "$OUTPUT_FILE"
rm -rf "$TMP_FILE"
