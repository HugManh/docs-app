#!/usr/bin/env bash
# Dựng thư mục content/ của Quartz từ vault Obsidian (HugManh/brain-IT).
#
# Vault tổ chức theo workflow (PARA + Johnny Decimal), web tổ chức theo người đọc,
# nên ở đây chỉ chọn phần public và đặt lại tên thư mục cho URL gọn:
#   30-Resources -> notes/    (ghi chú nguyên tử)
#   40-MOCs      -> /         (bản đồ chủ đề, nằm ở gốc để làm điều hướng chính)
#   _Attachments -> assets/   (ảnh nhúng)
#   web/         -> /         (trang chỉ có trên web: trang chủ, trang thư mục)
#
# Dùng: scripts/sync-vault.sh <đường-dẫn-vault> [thư-mục-đích=content]
set -euo pipefail

VAULT="${1:?Cần đường dẫn tới vault, ví dụ: scripts/sync-vault.sh ../brain-IT}"
DEST="${2:-content}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p "$DEST"
rm -rf "${DEST:?}"/*

# Chặn commit nhầm nội dung vault vào repo này. Không dùng .gitignore được vì Quartz
# bỏ qua file bị .gitignore; .git/info/exclude thì git tôn trọng nhưng Quartz không đọc.
if EXCLUDE="$(git -C "$ROOT" rev-parse --git-path info/exclude 2>/dev/null)"; then
  case "$EXCLUDE" in /* | [A-Za-z]:*) ;; *) EXCLUDE="$ROOT/$EXCLUDE" ;; esac
  DEST_REL="$(realpath --relative-to="$ROOT" "$DEST")"
  case "$DEST_REL" in
    ..*) ;; # thư mục đích nằm ngoài repo, không cần chặn
    *)
      mkdir -p "$(dirname "$EXCLUDE")"
      grep -qxF "/$DEST_REL/*" "$EXCLUDE" 2>/dev/null ||
        printf '/%s/*\n!/%s/.gitkeep\n' "$DEST_REL" "$DEST_REL" >>"$EXCLUDE"
      ;;
  esac
fi

cp -r "$VAULT/30-Resources" "$DEST/notes"
cp -r "$VAULT/40-MOCs/." "$DEST/"
cp -r "$VAULT/_Attachments" "$DEST/assets"
cp -r "$ROOT/web/." "$DEST/"

# Ghi chú không có `updated` trong frontmatter sẽ lấy ngày sửa từ filesystem.
# Bản copy (nhất là trên CI) mất mtime gốc, nên đặt lại theo commit cuối trong vault.
if git -C "$VAULT" rev-parse --git-dir >/dev/null 2>&1; then
  git -C "$VAULT" -c core.quotepath=false log --format='@%ct' --name-only -- 30-Resources 40-MOCs |
    awk '/^@/ { ts = $0; next } NF && !seen[$0]++ { print ts "\t" $0 }' |
    while IFS=$'\t' read -r ts path; do
      case "$path" in
        30-Resources/*) target="$DEST/notes/${path#30-Resources/}" ;;
        40-MOCs/*) target="$DEST/${path#40-MOCs/}" ;;
      esac
      [ -f "$target" ] && touch -d "$ts" "$target"
    done
fi

echo "Đã dựng $DEST từ $VAULT: $(find "$DEST" -name '*.md' | wc -l) trang markdown"
