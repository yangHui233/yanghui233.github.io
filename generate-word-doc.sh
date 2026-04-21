#!/usr/bin/env bash
# 生成 Word 可直接打开的 .doc（HTML 封装，样式保留度高于 pandoc 直转 docx）
# 用法：
#   ./generate-word-doc.sh
#   ./generate-word-doc.sh 自定义文件名.doc
#   INPUT=other.html ./generate-word-doc.sh
set -euo pipefail

cd "$(dirname "$0")"

INPUT="${INPUT:-index.html}"
OUTPUT="${1:-杨会-高级前端开发工程师-简历.doc}"

if [[ ! -f "$INPUT" ]]; then
  echo "❌ 找不到输入文件: $INPUT" >&2
  exit 1
fi

# 确保扩展名是 .doc（兼容 Word 双击打开）
if [[ "${OUTPUT##*.}" != "doc" ]]; then
  OUTPUT="${OUTPUT}.doc"
fi

cp "$INPUT" "$OUTPUT"
echo "✅ 已生成 Word 兼容文件: $OUTPUT ($(du -h "$OUTPUT" | cut -f1))"
echo "💡 用 Word / WPS 直接打开后，可再“另存为 .docx”。"
