#!/usr/bin/env bash
# 将 index.html 转成 Word (.docx)，基于 pandoc
# 用法：
#   ./generate-docx.sh                              # 默认输出
#   ./generate-docx.sh 自定义文件名.docx
#   INPUT=other.html ./generate-docx.sh
#
# 注意：HTML 里的自定义 CSS（变量、grid、伪元素等）在 docx 里无法 1:1 复刻，
#       本脚本只保留标题层级、列表、段落等结构化内容，视觉样式请以 PDF 版本为准。
set -euo pipefail

cd "$(dirname "$0")"

INPUT="${INPUT:-index.html}"
OUTPUT="${1:-杨会-高级前端开发工程师-简历.docx}"

if [[ ! -f "$INPUT" ]]; then
  echo "❌ 找不到输入文件: $INPUT" >&2
  exit 1
fi

if ! command -v pandoc >/dev/null 2>&1; then
  cat >&2 <<EOF
❌ 未检测到 pandoc，请先安装：

  macOS:   brew install pandoc
  Ubuntu:  sudo apt install pandoc
  其他:    https://pandoc.org/installing.html

EOF
  exit 1
fi

echo "📄 输入: $INPUT"
echo "💾 输出: $OUTPUT"
echo "🔧 pandoc: $(pandoc --version | head -1)"

# --from html                       输入格式
# --to docx                         输出格式
# --wrap=preserve                   保留换行
# --standalone                      生成完整文档
# -M lang=zh-CN                     设置中文语言
TMP_CLEAN="$(mktemp -t resume-clean.XXXXXX.html)"
trap 'rm -f "$TMP_CLEAN"' EXIT

# 把 <style>...</style> 整块去掉，避免 pandoc 误把 CSS 当正文抓进去
python3 - "$INPUT" "$TMP_CLEAN" <<'PY'
import re, sys, pathlib
src, dst = sys.argv[1], sys.argv[2]
html = pathlib.Path(src).read_text(encoding="utf-8")
html = re.sub(r"<style\b[^>]*>.*?</style>", "", html, flags=re.S | re.I)
html = re.sub(r"<script\b[^>]*>.*?</script>", "", html, flags=re.S | re.I)
pathlib.Path(dst).write_text(html, encoding="utf-8")
PY

pandoc "$TMP_CLEAN" \
  --from html \
  --to docx \
  --wrap=preserve \
  --standalone \
  -M lang=zh-CN \
  -o "$OUTPUT"

if [[ -f "$OUTPUT" ]]; then
  echo "✅ 生成完成: $OUTPUT ($(du -h "$OUTPUT" | cut -f1))"
  echo "💡 提示：docx 仅保留文字结构，美观度请以 PDF 版本为准。"
else
  echo "❌ 生成失败" >&2
  exit 1
fi
