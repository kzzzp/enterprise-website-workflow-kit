# 企业官网生成工作流 Kit

这是一套给 Codex 使用的中文企业官网静态 HTML 生成工作流。安装后，可以通过 `enterprise-website-delivery` skill 让 Codex 根据公司简介生成多页面静态企业官网。

## 这套包里有什么

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

`enterprise-website-delivery` 是主 skill。工作流文件已经内置在这个 skill 里面：

```text
skills/enterprise-website-delivery/references/enterprise-website-workflow.md
```

所以安装主 skill 时，工作流会一起安装，不需要单独安装工作流。

## 推荐安装

Windows PowerShell:

```powershell
irm https://raw.githubusercontent.com/kzzzp/enterprise-website-workflow-kit/main/install.ps1 | iex
```

macOS / Linux:

```bash
curl -fsSL https://raw.githubusercontent.com/kzzzp/enterprise-website-workflow-kit/main/install.sh | bash
```

这会把下面目录安装到 Codex 的 skill 目录：

```text
skills/enterprise-website-delivery
```

安装后重启 Codex，让新 skill 出现在可用 skill 列表中。

## 可选：同时安装设计增强 Skill

如果想让 Codex 同时安装两个设计增强 skill，可以使用下面命令。

Windows PowerShell:

```powershell
$env:WITH_DESIGN_SKILLS="1"; irm https://raw.githubusercontent.com/kzzzp/enterprise-website-workflow-kit/main/install.ps1 | iex
```

macOS / Linux:

```bash
WITH_DESIGN_SKILLS=1 curl -fsSL https://raw.githubusercontent.com/kzzzp/enterprise-website-workflow-kit/main/install.sh | bash
```

这会额外尝试安装：

- `design-taste-frontend`
- `ui-ux-pro-max`

注意：Codex 不会因为 `SKILL.md` 里写了这两个名字就自动下载它们。它们是外部增强 skill，不属于本仓库的主工作流。没有安装它们时，`enterprise-website-delivery` 仍然可以按内置工作流执行，只是审美检查能力会少一些。

## 手动安装

如果一条命令安装不可用，可以直接下载 GitHub ZIP，然后复制这个文件夹：

```text
skills/enterprise-website-delivery
```

到本机 Codex skill 目录：

Windows:

```text
%USERPROFILE%\.codex\skills\enterprise-website-delivery
```

macOS / Linux:

```text
~/.codex/skills/enterprise-website-delivery
```

复制后重启 Codex。

## 直接使用 Skill Installer

如果你想不用安装脚本，也可以直接运行 Codex 自带的 skill installer。

Windows PowerShell:

```powershell
python "$env:USERPROFILE\.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py" --repo kzzzp/enterprise-website-workflow-kit --path skills/enterprise-website-delivery
```

macOS / Linux:

```bash
python3 "$HOME/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py" --repo kzzzp/enterprise-website-workflow-kit --path skills/enterprise-website-delivery
```

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
