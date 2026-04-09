#!/usr/bin/env bash
# Platform release builds for DBStudio (installers/signing are platform-specific).
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
flutter pub get
case "$(uname -s)" in
  Darwin)
    flutter build macos --release
    ;;
  Linux)
    flutter build linux --release
    ;;
  MINGW*|MSYS*|CYGWIN*)
    flutter build windows --release
    ;;
  *)
    echo "Unsupported OS; run flutter build <target> manually."
    exit 1
    ;;
esac
