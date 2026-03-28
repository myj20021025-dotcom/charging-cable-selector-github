# 充电站电缆截面选型（静态页）

依据 GB 50217-2018 附录 C、D 的辅助计算页。部署 **GitHub Pages** 后，将 **https 链接** 发给客户即可在微信内打开。

## 一键部署（本机已装 Git 与 GitHub CLI）

1. 安装 CLI（若未装）：`winget install GitHub.cli`
2. 在本目录打开 **PowerShell**，执行：
   ```powershell
   .\deploy.ps1
   ```
3. 首次会提示 `gh auth login`，按指引在浏览器完成登录。
4. 脚本会创建公开仓库 `charging-cable-selector-github`、推送 `main` 并尝试开启 Pages。

访问地址示例：`https://<你的用户名>.github.io/charging-cable-selector-github/`

## 手动开启 Pages

若脚本未成功开启：仓库 **Settings → Pages** → Source 选 **Deploy from a branch** → **main** / **/(root)** → Save。
