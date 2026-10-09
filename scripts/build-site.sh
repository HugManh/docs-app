#!/usr/bin/env bash
# Build một site: dựng content từ vault, chọn cấu hình của site rồi chạy Quartz.
#
# Dùng: scripts/build-site.sh <site> <đường-dẫn-vault> [tham số thêm cho `quartz build`]
#   scripts/build-site.sh brain-it ../brain-IT --serve      # xem thử ở máy
#   scripts/build-site.sh brain-it .vault -o out/brain-it   # CI
set -euo pipefail

SITE="${1:?Cần tên site}"
VAULT="${2:?Cần đường dẫn tới vault}"
shift 2
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

bash scripts/sync-vault.sh "$SITE" "$VAULT" content

# Quartz luôn đọc quartz.config.yaml ở gốc repo (file này được .gitignore).
cp "sites/$SITE/quartz.config.yaml" quartz.config.yaml
npm run --silent install-plugins

QUARTZ_SITE="$SITE" npx quartz build "$@"
