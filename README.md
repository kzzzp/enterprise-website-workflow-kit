# 企业官网生成工作流 Kit

这是一套给 Codex 使用的中文企业官网静态 HTML 生成工作流。安装后，可以通过 `enterprise-website-delivery` skill 让 Codex 根据公司简介生成多页面静态企业官网。

## 仓库结构

```text
skills/
  enterprise-website-delivery/
    SKILL.md
    agents/openai.yaml
    references/enterprise-website-workflow.md
prompts/
  start-enterprise-site.md
install.ps1
install.sh
scripts/check-portability.py
```

`references/enterprise-website-workflow.md` 是工作流正文，安装后由 skill 使用相对路径读取，不再依赖某台电脑上的固定目录。

## 一条命令安装

发布到 GitHub 后，先把下面命令里的 `OWNER/REPO` 换成你的仓库，例如 `yourname/enterprise-website-workflow-kit`。

Windows PowerShell:

```powershell
python "$env:USERPROFILE\.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py" --repo OWNER/REPO --path skills/enterprise-website-delivery
```

macOS / Linux:

```bash
python3 "$HOME/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py" --repo OWNER/REPO --path skills/enterprise-website-delivery
```

也可以使用仓库里的安装脚本。发布前先把 `install.ps1` 和 `install.sh` 里的默认 `YOUR_GITHUB_USERNAME/enterprise-website-workflow-kit` 改成你的真实仓库名。

Windows:

```powershell
irm https://raw.githubusercontent.com/OWNER/REPO/main/install.ps1 | iex
```

macOS / Linux:

```bash
curl -fsSL https://raw.githubusercontent.com/OWNER/REPO/main/install.sh | bash
```

安装后重启 Codex，让新 skill 出现在可用 skill 列表中。

## 设计依赖 Skill

本 kit 会优先使用这些设计增强 skill：

- `design-taste-frontend`
- `ui-ux-pro-max`

重要说明：Codex 不会因为 `SKILL.md` 里写了这两个名字就自动下载它们。只有在任务执行时，当前 Codex 代理读到 skill 说明，并且环境允许联网、能运行 `skill-installer` 时，才可能按说明尝试安装。

推荐在第一次安装时一并安装依赖：

Windows:

```powershell
$env:WITH_DESIGN_SKILLS="1"; irm https://raw.githubusercontent.com/OWNER/REPO/main/install.ps1 | iex
```

macOS / Linux:

```bash
WITH_DESIGN_SKILLS=1 curl -fsSL https://raw.githubusercontent.com/OWNER/REPO/main/install.sh | bash
```

依赖 skill 安装源：

- `design-taste-frontend`: `Leonxlnx/taste-skill`, repo path `skills/taste-skill`
- `ui-ux-pro-max`: `nextlevelbuilder/ui-ux-pro-max-skill`, repo path `.claude/skills/ui-ux-pro-max`

## 使用提示词

安装并重启 Codex 后，可以直接说：

```text
使用 enterprise-website-delivery skill，根据下面公司简介生成一个中文企业官网静态 HTML 网站。

公司简介如下：
【粘贴公司简介】
```

如果公司名称、主营业务、有效联系方式、城市或服务区域缺失，skill 应先追问，不应直接生成占位联系方式。

## 发布前检查

在推到 GitHub 前运行：

```powershell
python scripts/check-portability.py
```

它会检查是否还残留本机绝对路径、日期型工作目录或旧项目目录名。
