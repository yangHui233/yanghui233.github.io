#!/usr/bin/env bash
# 将 index.html 转成 PDF（零依赖，使用系统已安装的 Chrome / Edge / Chromium）
# 用法：
#   ./generate-pdf.sh              # 生成 resume.pdf
#   ./generate-pdf.sh my.pdf       # 指定输出文件名
#   INPUT=other.html ./generate-pdf.sh
set -euo pipefail

cd "$(dirname "$0")"

INPUT="${INPUT:-index.html}"
OUTPUT="${1:-杨会-高级前端开发工程师-简历.pdf}"

if [[ ! -f "$INPUT" ]]; then
  echo "❌ 找不到输入文件: $INPUT" >&2
  exit 1
fi

# 依次尝试常见的无头浏览器路径
CANDIDATES=(
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  "/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary"
  "/Applications/Chromium.app/Contents/MacOS/Chromium"
  "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
  "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"
  "$(command -v google-chrome || true)"
  "$(command -v chromium || true)"
  "$(command -v chromium-browser || true)"
  "$(command -v microsoft-edge || true)"
)

BROWSER=""
for c in "${CANDIDATES[@]}"; do
  if [[ -n "$c" && -x "$c" ]]; then
    BROWSER="$c"
    break
  fi
done

if [[ -z "$BROWSER" ]]; then
  echo "❌ 未检测到 Chrome / Edge / Chromium，请先安装任意一个，或改用 generate-pdf.js" >&2
  exit 1
fi

ABS_INPUT="file://$(cd "$(dirname "$INPUT")" && pwd)/$(basename "$INPUT")"

echo "🖨  使用浏览器: $BROWSER"
echo "📄 输入:       $ABS_INPUT"
echo "💾 输出:       $OUTPUT"

"$BROWSER" \
  --headless=new \
  --disable-gpu \
  --no-pdf-header-footer \
  --print-to-pdf-no-header \
  --no-margins \
  --hide-scrollbars \
  --virtual-time-budget=5000 \
  --print-to-pdf="$OUTPUT" \
  "$ABS_INPUT" 2>/dev/null

if [[ -f "$OUTPUT" ]]; then
  echo "✅ 生成完成: $OUTPUT ($(du -h "$OUTPUT" | cut -f1))"
else
  echo "❌ 生成失败" >&2
  exit 1
fi
