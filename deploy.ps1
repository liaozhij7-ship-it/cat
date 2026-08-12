# 猫咪营养记录 - 一键部署到 GitHub Pages
# 用法:
#   1. 在 GitHub 上创建一个空仓库(Public),比如叫 cat-feeding-tracker
#   2. 编辑下面这一行,改成你的仓库 URL:
#      $repoUrl = "https://github.com/liaozhij7-ship-it/cat.git"
#   3. 在 PowerShell 里执行: .\deploy.ps1

# 强制 UTF-8,避免 PowerShell 5.1 的 GBK 中文乱码
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

$ErrorActionPreference = 'Stop'

# ========== 在这里填你的 GitHub 仓库 URL ==========
$repoUrl = "https://github.com/liaozhij7-ship-it/cat.git"
# ===================================================

$branch = "main"

if ($repoUrl -match "你的用户名") {
    Write-Host "请先编辑 deploy.ps1,把 `$repoUrl 改成你的 GitHub 仓库地址" -ForegroundColor Red
    exit 1
}

# 检查 git
try { git --version | Out-Null } catch {
    Write-Host "未检测到 git,请先安装: https://git-scm.com/download/win" -ForegroundColor Red
    exit 1
}

# 初始化
if (-not (Test-Path .git)) {
    Write-Host "[1/5] git init" -ForegroundColor Cyan
    git init
    git checkout -b $branch
} else {
    Write-Host "[1/5] 已存在 .git,跳过 init" -ForegroundColor Yellow
}

Write-Host "[2/5] git add" -ForegroundColor Cyan
git add .

Write-Host "[3/5] git commit" -ForegroundColor Cyan
# 判断是否有 commit: 检查 HEAD 引用是否存在
$hasCommit = (Test-Path .git/refs/heads/main) -or (Test-Path .git/refs/heads/master)
if ($hasCommit) {
    try {
        git commit -m "update: 猫咪营养记录 $(Get-Date -Format 'yyyy-MM-dd HH:mm')" --allow-empty
    } catch {
        # 没有改动也无所谓
    }
} else {
    git commit -m "init: 猫咪营养记录"
}

# 设置 remote
$existingRemote = ""
try {
    $existingRemote = git remote get-url origin 2>&1 | Out-String
    $existingRemote = $existingRemote.Trim()
} catch {
    $existingRemote = ""
}

if ($existingRemote -eq $repoUrl) {
    Write-Host "[4/5] remote 已配置" -ForegroundColor Yellow
} elseif ($existingRemote) {
    Write-Host "[4/5] 更新 remote: $existingRemote -> $repoUrl" -ForegroundColor Cyan
    git remote set-url origin $repoUrl
} else {
    Write-Host "[4/5] 添加 remote: $repoUrl" -ForegroundColor Cyan
    git remote add origin $repoUrl
}

Write-Host "[5/5] git push" -ForegroundColor Cyan
git push -u origin $branch

Write-Host ""
Write-Host "✅ 推送完成!" -ForegroundColor Green
Write-Host ""
Write-Host "接下来:" -ForegroundColor Yellow
Write-Host "  1. 打开仓库 -> Settings -> Pages"
Write-Host "  2. Source 选 '$branch' 分支,根目录 /"
Write-Host "  3. Save,等 1-2 分钟"
Write-Host "  4. 访问 https://你的用户名.github.io/cat-feeding-tracker/"
Write-Host ""
Write-Host "手机建议把这个 URL 添加到主屏幕,跟 App 一样用。" -ForegroundColor Yellow
