<p align="center">
  <img src="assets/niceshot.png" alt="NiceShot — Caps Lock スクリーンショットレイヤー" width="100%">
</p>

<p align="center">
  <strong>Caps Lock をスクリーンショットレイヤーに。単独タップは通常の Caps Lock のまま。</strong>
</p>

<p align="center">
  <a href="README.md">English</a> · <a href="README.zh-CN.md">简体中文</a> · 日本語
</p>

```text
 _   _ ___ ____ _____ ____  _   _  ___ _____
| \ | |_ _/ ___| ____/ ___|| | | |/ _ \_   _|
|  \| || | |   |  _| \___ \| |_| | | | || |
| |\  || | |___| |___ ___) |  _  | |_| || |
|_| \_|___\____|_____|____/|_| |_|\___/ |_|

        CAPS LOCK → SCREENSHOT LAYER
```

NiceShot は、macOS 標準の `/usr/sbin/screencapture` と AppleScript、無料・オープンソースの Karabiner-Elements だけで構成されたスクリーンショットワークフローです。保存ダイアログ、Preview の自動起動、クラウドアップロードはありません。

## ショートカット

Shift なしは一時的な情報としてクリップボードだけに保存します。Shift ありは最終 PNG を保存し、同じ画像をクリップボードにも入れます。

| ショートカット | 撮影 | 結果 |
|---|---|---|
| `Caps + S` | 範囲 | クリップボードのみ |
| `Caps + W` | ウインドウ、影なし | クリップボードのみ |
| `Caps + F` | 全画面 | クリップボードのみ |
| `Caps + Shift + S` | 範囲 | PNG + クリップボード |
| `Caps + Shift + W` | ウインドウ、影なし | PNG + クリップボード |
| `Caps + Shift + F` | 全画面 | PNG + クリップボード |

`Caps Lock` を単独でタップすると、通常の Caps Lock として動作します。

## インストール

1. [Karabiner-Elements](https://karabiner-elements.pqrs.org/) をインストールして起動します。
2. Karabiner の案内に従い、バックグラウンド動作、アクセシビリティ、仮想 HID ドライバ、および `Karabiner-Console-User-Server` の画面収録を許可します。
3. 次を実行します。

```zsh
chmod +x install.sh uninstall.sh
./install.sh
```

標準の保存先は `~/Pictures/Screenshotschichu` です。変更する場合：

```zsh
NICESHOT_SAVE_DIR="$HOME/Pictures/NiceShot" ./install.sh
```

インストーラは既存設定を読み込み、日時付きバックアップを作成して、選択中のプロファイルに NiceShot のルールを一つだけ追加します。既存ルールは保持されます。

## アンインストール

```zsh
./uninstall.sh
```

NiceShot のルールだけを削除し、保存済みスクリーンショットは削除しません。設定は変更前にバックアップされます。

## プライバシー

- 有料スクリーンショットアプリ不要
- クリップボード専用撮影では一時 PNG を作成しない
- クラウドアップロードやテレメトリなし
- Desktop や Downloads へ自動保存しない
- SIP、Gatekeeper、システムセキュリティポリシーを変更しない

## ライセンス

MIT

