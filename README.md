# 🐱 猫咪营养记录

一个单文件HTML应用，用于记录猫咪每天除了猫粮之外喂的营养品、餐包、罐头等，以及营养品开封时间追踪。

## ✨ 功能

- 📅 **日历视图**：按月切换，点击任意日期查看/添加当日喂食记录
- 🍱 **手动记录**：每天可记录多条（餐包/罐头/营养品/其他），支持名称、用量、备注
- 📦 **营养品管理**：记录每个营养品的开封时间，自动计算已开天数和保质期剩余
- 🔄 **跨设备同步**：通过「云同步」按钮把数据编码到URL，手机粘贴同一链接即可同步
- 💾 **本地存储**：数据保存在浏览器 localStorage，刷新不丢失
- 📤 **导入/导出**：可导出 JSON 备份，也可从其他设备导入
- 📱 **手机友好**：响应式设计，触摸操作

## 🚀 部署到 GitHub Pages（手机访问）

### 第一次部署

1. **创建 GitHub 仓库**
   - 登录 GitHub → New repository
   - 仓库名建议：`cat-feeding-tracker`（设为 Public）
   - 不要勾选 "Add a README file"

2. **把代码推上去**
   ```bash
   cd cat-feeding-tracker
   git init
   git add index.html
   git commit -m "init: 猫咪营养记录"
   git branch -M main
   git remote add origin https://github.com/你的用户名/cat-feeding-tracker.git
   git push -u origin main
   ```

3. **开启 GitHub Pages**
   - 进入仓库 → Settings → Pages
   - Source 选择 `main` 分支，根目录 `/`
   - 点击 Save
   - 等待 1-2 分钟，会生成一个 URL：
     `https://你的用户名.github.io/cat-feeding-tracker/`

4. **手机访问**
   - 把上面的 URL 存到手机主屏幕（Safari/Chrome → 分享 → 添加到主屏幕）
   - 之后点击图标就能直接打开

### 后续更新

```bash
git add index.html
git commit -m "update: 优化XX"
git push
```
GitHub Pages 会自动更新（等 30 秒左右）。

## 📲 跨设备数据同步

应用默认数据存在当前设备的 localStorage 里，多设备不互通。同步方法：

### 方法一：云同步链接（推荐）
1. 在主设备上点「☁️ 同步到云」按钮
2. 应用会复制一个很长的 URL 到剪贴板
3. 把这个 URL 发到手机（微信/邮件都行）
4. 手机打开这个 URL，弹出「检测到同步数据」→ 确认导入
5. 之后在手机上「同步到云」→ 把新链接发回电脑 → 电脑打开导入
6. 重复以上就能保持多设备一致

> 注意：链接很长，可能被微信/部分聊天工具截断。建议用邮件、GitHub Gist、或者 Telegram 发送。

### 方法二：JSON 导出/导入
1. 设备 A 点「📤 导出数据」→ 下载 JSON 文件
2. 把文件传到设备 B（AirDrop、微信传文件、邮件附件等）
3. 设备 B 点「📥 导入数据」→ 选这个文件 → 选「合并」保留两边数据

## 🛠 技术栈

- 纯 HTML + CSS + JavaScript（无依赖）
- 数据存 `localStorage`
- 同步用 `URL hash + base64` 编码（无需后端）
- 单文件 `index.html` ~28KB

## 📁 目录结构

```
cat-feeding-tracker/
├── index.html      # 单文件应用（包含所有 HTML/CSS/JS）
└── README.md       # 本文件
```

## 💡 使用建议

- 把页面添加到手机主屏幕，App 一样用
- 营养品开封时立刻添加，能自动追踪保质期
- 设置保质期后会在「已开封」列表里显示颜色警告：
  - 绿色 = 充足（剩 > 7 天）
  - 橙色 = 快过期（剩 ≤ 7 天）
  - 红色 = 临期或已过期（剩 ≤ 3 天）

## 🔒 隐私

- 所有数据只存在你本地的 localStorage
- 同步链接里包含你的全部数据，注意不要发到公开场合
- 关闭浏览器不会清掉数据（除非手动清缓存）
