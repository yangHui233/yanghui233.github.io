#!/usr/bin/env node
/**
 * 基于 Puppeteer 把 index.html 渲染为 PDF。
 *
 * 用法:
 *   node generate-pdf.js                 # 输出 resume.pdf
 *   node generate-pdf.js output.pdf      # 自定义输出路径
 *   node generate-pdf.js output.pdf other.html
 *
 * 首次使用请先安装依赖：
 *   npm install
 */

const path = require('path');
const fs = require('fs');

async function main() {
  const output = path.resolve(process.argv[2] || '杨会-高级前端开发工程师-简历.pdf');
  const input = path.resolve(process.argv[3] || 'index.html');

  if (!fs.existsSync(input)) {
    console.error(`❌ 找不到输入文件: ${input}`);
    process.exit(1);
  }

  let puppeteer;
  try {
    puppeteer = require('puppeteer');
  } catch (err) {
    console.error('❌ 未安装 puppeteer，请先执行: npm install');
    process.exit(1);
  }

  console.log('🚀 启动无头浏览器...');
  const browser = await puppeteer.launch({
    headless: 'new',
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
  });

  try {
    const page = await browser.newPage();
    await page.emulateMediaType('print');

    const fileUrl = 'file://' + input;
    console.log(`📄 加载: ${fileUrl}`);
    await page.goto(fileUrl, { waitUntil: ['load', 'networkidle0'] });

    // 等待字体完全加载，保证渲染一致
    await page.evaluate(async () => {
      if (document.fonts && document.fonts.ready) {
        await document.fonts.ready;
      }
    });

    console.log(`🖨  导出 PDF -> ${output}`);
    await page.pdf({
      path: output,
      format: 'A4',
      printBackground: true,
      preferCSSPageSize: true,
      displayHeaderFooter: false,
      margin: { top: '0mm', right: '0mm', bottom: '0mm', left: '0mm' },
    });

    const size = (fs.statSync(output).size / 1024).toFixed(1);
    console.log(`✅ 生成完成: ${output} (${size} KB)`);
  } finally {
    await browser.close();
  }
}

main().catch((err) => {
  console.error('❌ 生成失败:', err);
  process.exit(1);
});
