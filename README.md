# 内推招聘系统

一个简易内推招聘网页系统，支持岗位列表筛选、岗位详情查看、岗位投递、生成分享二维码。

## 功能

- 首页 Banner 展示公司简介
- 岗位列表 + 三级筛选（期望城市、招聘类型、岗位类型）
- 岗位详情页面
- 投递功能 - 跳转飞书多维表格表单
- 分享功能 - 生成带二维码的职位分享卡片
- 返回列表功能

## 技术栈

前端纯 HTML/CSS/JavaScript，使用 CDN 加载 qrcodejs 和 html2canvas。

数据存储在飞书多维表格（Lark Base），支持直接在表格中增删改维护。

## 文件

- `index.html` - 首页
- `detail.html` - 岗位详情页
- `jobs.json` - 岗位数据
- `sync-data.sh` - 从 Lark Base 同步数据脚本

## 快速部署

支持部署到任意静态网站托管平台，推荐以下免费平台：

- **GitHub Pages** - 将本目录推送到 GitHub 仓库，开启 Pages 即可
- **Vercel** - `npx vercel deploy --prod`
- **Netlify** - `npx netlify-cli deploy --prod --dir=.`
- **Cloudflare Pages** - `npx wrangler pages deploy .`
- **飞书妙搭 (Lark Apps)** - 在妙搭中创建 HTML 站点，上传文件