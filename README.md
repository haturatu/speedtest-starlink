# speedtest-starlink

Starlinkのインターネット回線速度を定期的に測定し、結果をファイルに記録するためのスクリプトです。
`speedtest-cli` を使用して下り・上りの速度とPingを測定します。
結果は指定されたファイルに蓄積されていきます。

## 依存関係

このスクリプトを実行するには `speedtest-cli` が必要です。

**インストール例 (Debian/Ubuntu):**
```
sudo apt update
sudo apt install speedtest-cli
```

**インストール例 (pip):**
```
pip install speedtest-cli
```

## スクリプトについて

### `speedtest-starlink.sh`

このスクリプトは、`speedtest-cli` を実行し、その結果にタイムスタンプを付けて `/var/www/starlink/starlink-jp` ファイルに出力します。
ファイルが既に存在する場合、新しい結果がファイルの先頭に追加され、古い結果は保持されます。

**注意:** スクリプト内の `OUTPUT_FILE` (`/var/www/starlink/starlink-jp`) への書き込み権限が、cronを実行するユーザーに必要です。必要に応じてパスや権限を変更してください。

## Cronでの定期実行

このスクリプトを定期的に実行するには、`crontab` を使用します。

1. `crontab -e` コマンドでcrontab編集画面を開きます。
2. 以下の行を追加します。スクリプトのパス (`/opt/sh/speedtest-starlink.sh`) は環境に合わせて確認・修正してください。

12時間ごとに実行する例:  
```crontab
00 */12 * * * bash -l -c '/opt/sh/speedtest-starlink.sh'
```
