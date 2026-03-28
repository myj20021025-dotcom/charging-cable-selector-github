# 在本机 PowerShell 中执行：右键 “使用 PowerShell 运行”，或在终端 cd 到本目录后运行 .\deploy.ps1
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$gh = Get-Command gh -ErrorAction SilentlyContinue
if (-not $gh) {
    Write-Host "未找到 gh。请先安装: winget install GitHub.cli" -ForegroundColor Yellow
    exit 1
}

gh auth status 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "需要登录 GitHub，按提示在浏览器完成授权..." -ForegroundColor Cyan
    gh auth login -h github.com -p https -w
}

$repoName = "charging-cable-selector-github"
$owner = gh api user -q .login
if (-not $owner) { Write-Host "无法获取当前用户"; exit 1 }

Write-Host "创建远程仓库并推送: $owner/$repoName" -ForegroundColor Cyan
gh repo create $repoName --public --source=. --remote=origin --description "充电站电缆截面选型静态页 (GB 50217 附录 C/D)" --push

Write-Host "尝试开启 GitHub Pages (main / root)..." -ForegroundColor Cyan
$pagesBody = '{"source":{"branch":"main","path":"/"}}'
$pagesBody | gh api -X POST "repos/$owner/$repoName/pages" --input - 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Pages 接口若已开启可能报已存在，可忽略。请到仓库 Settings → Pages 手动选择 main / (root)。" -ForegroundColor Yellow
} else {
    Write-Host "Pages 已提交创建请求，约 1 分钟后可用。" -ForegroundColor Green
}

$pagesUrl = "https://$owner.github.io/$repoName/"
Write-Host ""
Write-Host "部署完成后访问地址（以实际仓库名为准）: $pagesUrl" -ForegroundColor Green
Write-Host "若 404，请等待 1～2 分钟或在 Settings → Pages 确认已启用。" -ForegroundColor Gray
