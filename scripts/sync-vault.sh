#!/usr/bin/env bash
# Dựng thư mục content/ của Quartz cho một site từ vault Obsidian của nó.
#
# Vault tổ chức theo workflow của người viết, web tổ chức theo người đọc, nên chỉ
# những thư mục khai báo trong sites/<site>/sync.map mới được đưa lên (và đổi tên
# cho URL gọn). sites/<site>/web/ chứa các trang chỉ có trên web (trang chủ...).
#
# Dùng: scripts/sync-vault.sh <site> <đường-dẫn-vault> [thư-mục-đích=content]
set -euo pipefail

SITE="${1:?Cần tên site, ví dụ: scripts/sync-vault.sh brain-it ../brain-IT}"
VAULT="${2:?Cần đường dẫn tới vault}"
DEST="${3:-content}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SITE_DIR="$ROOT/sites/$SITE"
MAP="$SITE_DIR/sync.map"

[ -f "$MAP" ] || { echo "Không tìm thấy $MAP" >&2; exit 1; }

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

# Đọc sync.map: mỗi dòng "<thư-mục-vault> <đích>", bỏ dòng trống và comment
SRCS=()
DSTS=()
while read -r src dst _; do
  case "$src" in "" | \#*) continue ;; esac
  SRCS+=("$src")
  DSTS+=("$dst")
  mkdir -p "$DEST/$dst"
  cp -r "$VAULT/$src/." "$DEST/$dst/"
done <"$MAP"

[ -d "$SITE_DIR/web" ] && cp -r "$SITE_DIR/web/." "$DEST/"

# Ghi chú không có `updated` trong frontmatter sẽ lấy ngày sửa từ filesystem.
# Bản copy (nhất là trên CI) mất mtime gốc, nên đặt lại theo commit cuối trong vault.
if git -C "$VAULT" rev-parse --git-dir >/dev/null 2>&1; then
  git -C "$VAULT" -c core.quotepath=false log --format='@%ct' --name-only -- "${SRCS[@]}" |
    awk '/^@/ { ts = $0; next } NF && !seen[$0]++ { print ts "\t" $0 }' |
    while IFS=$'\t' read -r ts path; do
      for i in "${!SRCS[@]}"; do
        case "$path" in
          "${SRCS[$i]}"/*)
            target="$DEST/${DSTS[$i]}/${path#"${SRCS[$i]}"/}"
            [ -f "$target" ] && touch -d "$ts" "$target"
            break
            ;;
        esac
      done
    done
fi

echo "[$SITE] Đã dựng $DEST từ $VAULT: $(find "$DEST" -name '*.md' | wc -l) trang markdown"
