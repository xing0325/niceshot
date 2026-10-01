<p align="center">
  <img src="assets/niceshot.png" alt="NiceShot — Caps Lock Screenshot Layer" width="100%">
</p>

<p align="center">
  <strong>Caps Lock becomes a screenshot layer. Tap it alone and it is still Caps Lock.</strong>
</p>

<p align="center">
  English · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a>
</p>

```text
 _   _ ___ ____ _____ ____  _   _  ___ _____
| \ | |_ _/ ___| ____/ ___|| | | |/ _ \_   _|
|  \| || | |   |  _| \___ \| |_| | | | || |
| |\  || | |___| |___ ___) |  _  | |_| || |
|_| \_|___\____|_____|____/|_| |_|\___/ |_|

          CAPS LOCK → SCREENSHOT LAYER
```

NiceShot is a small, open-source macOS screenshot workflow built from free tools only: the system `/usr/sbin/screencapture`, macOS AppleScript, and Karabiner-Elements. It installs no third-party screenshot app, opens no save dialog, launches no Preview window, and uploads nothing.

## The idea

No Shift means the screenshot is temporary and exists only in the clipboard. Shift means you deliberately want to keep it: NiceShot writes the final PNG and also puts the same image on the clipboard.

| Shortcut | Capture | Result |
|---|---|---|
| `Caps + S` | Selection | Clipboard only |
| `Caps + W` | Window, no shadow | Clipboard only |
| `Caps + F` | Full screen | Clipboard only |
| `Caps + Shift + S` | Selection | PNG + clipboard |
| `Caps + Shift + W` | Window, no shadow | PNG + clipboard |
| `Caps + Shift + F` | Full screen | PNG + clipboard |

Tap `Caps Lock` by itself to use normal Caps Lock.

## Requirements

- macOS
- [Karabiner-Elements](https://karabiner-elements.pqrs.org/) — free and open source
- The macOS-built-in `screencapture`, `osascript`, and Ruby runtime

## Install

1. Install and open Karabiner-Elements.
2. Grant the permissions Karabiner requests:
   - Background activity for both Karabiner services
   - Accessibility for `Karabiner-Core-Service`
   - The Karabiner virtual HID driver extension
   - Screen & System Audio Recording for `Karabiner-Console-User-Server`
3. Run:

```zsh
chmod +x install.sh uninstall.sh
./install.sh
```

The default save directory is:

```text
~/Pictures/Screenshotschichu
```

Choose another directory during installation if you prefer:

```zsh
NICESHOT_SAVE_DIR="$HOME/Pictures/NiceShot" ./install.sh
```

The installer:

- reads the current Karabiner configuration;
- creates a timestamped backup;
- appends one NiceShot rule to the selected profile;
- preserves every existing rule;
- creates the screenshot directory if needed;
- is idempotent, so running it twice does not duplicate the rule.

## Verify

1. Press `Caps + S`, select an area, then paste into any rich-text or image app.
2. Confirm no screenshot appeared in Desktop, Downloads, or Pictures.
3. Press `Caps + W`, click a window, and paste it. The window should have no shadow.
4. Press `Caps + Shift + S`, select an area, and confirm both:
   - the image can be pasted immediately;
   - a file named `Screenshot-YYYY-MM-DD-HH.MM.SS.png` exists in the save directory.

## Uninstall

```zsh
./uninstall.sh
```

Uninstall removes only the rule whose description is `NiceShot: Caps Lock Screenshot Layer`. It backs up the configuration first and does not delete saved screenshots.

## Privacy and design constraints

- No paid screenshot software
- No temporary PNG for clipboard-only captures
- No cloud upload or telemetry
- No automatic Preview window
- No automatic Desktop or Downloads files
- No SIP, Gatekeeper, or security-policy changes
- Window captures omit the macOS shadow by default

## Project layout

```text
niceshot/
├── assets/niceshot.png
├── karabiner/rule.template.json
├── scripts/install.rb
├── scripts/uninstall.rb
├── install.sh
└── uninstall.sh
```

## License

MIT

