#!/usr/bin/env bash
# Đưa bản build của MỘT site lên nhánh gh-pages, chỉ thay thư mục <site>/ của nó.
# Các site khác trên gh-pages giữ nguyên, nên không phải build lại chúng.
#
# Dùng (trên CI): scripts/publish-site.sh <site> <thư-mục-build>
# Cần GITHUB_TOKEN có quyền contents: write và GITHUB_REPOSITORY
# (hoặc PUBLISH_REMOTE trỏ tới repo khác, ví dụ để thử ở máy).
set -euo pipefail

SITE="${1:?Cần tên site}"
BUILD_DIR="$(cd "${2:?Cần thư mục build}" && pwd)"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REMOTE="${PUBLISH_REMOTE:-https://x-access-token:${GITHUB_TOKEN:?}@github.com/${GITHUB_REPOSITORY:?}.git}"
WORK="$(mktemp -d)"

if git clone --quiet --depth 1 --branch gh-pages "$REMOTE" "$WORK"; then
  cd "$WORK"
else
  # Lần deploy đầu tiên: tạo nhánh gh-pages rỗng
  cd "$WORK"
  git init --quiet
  git checkout --quiet --orphan gh-pages
  git remote add origin "$REMOTE"
fi

git config core.autocrlf false
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

rm -rf "./$SITE"
cp -r "$BUILD_DIR" "./$SITE"
cp "$ROOT/landing/index.html" ./index.html
touch .nojekyll # để GitHub Pages không bỏ qua file/thư mục bắt đầu bằng "_"

git add -A
if git diff --cached --quiet; then
  echo "[$SITE] Không có thay đổi"
  exit 0
fi
git commit --quiet -m "deploy($SITE): ${GITHUB_SHA:-local}"

# Site khác có thể vừa push; mỗi site chỉ sửa thư mục riêng nên rebase không xung đột.
for attempt in 1 2 3 4 5; do
  if git push --quiet origin gh-pages; then
    echo "[$SITE] Đã đưa lên gh-pages"
    exit 0
  fi
  echo "[$SITE] Push bị từ chối (lần $attempt), rebase rồi thử lại..."
  git pull --quiet --rebase origin gh-pages
done

echo "[$SITE] Không push được lên gh-pages" >&2
exit 1
