---
name: enterprise-website-delivery
description: Use when generating, redesigning, or delivering a Chinese enterprise/company official website as a static multi-page HTML site from company intro material. Enforces the bundled enterprise website workflow, required information questioning, three industry template directions, controlled palettes, realistic image strategy, AIO files, and screenshot-based verification.
---

# Enterprise Website Delivery

Use this skill for 企业官网、公司官网、静态官网、多页面官网、官网交付、官网生成, especially when the user provides company intro material and expects Codex to generate a deployable static HTML site.

This skill is the Codex wrapper. The detailed workflow is bundled as a relative reference file so it can be installed from GitHub without machine-specific paths.

## Required Workflow

Always read this file before generating site files:

```text
references/enterprise-website-workflow.md
```

Resolve it relative to this `SKILL.md` directory. Do not use old absolute paths from a user's computer. If the user provides a newer workflow path for the current task, read that explicit path as an override and say which workflow was used.

The workflow is UTF-8. If reading through Windows PowerShell, use `Get-Content -Encoding UTF8`. Mojibake means the workflow was not successfully read and generation must stop.

Do not paste the whole workflow back to the user. Extract only the rules needed for the current customer/site.

## Design Skill Dependencies

Before creating HTML/CSS/JS/images, check whether these design enhancement skills are available:

- `design-taste-frontend`
- `ui-ux-pro-max`

Codex does not automatically download missing skills just because they are mentioned here. If either skill is missing, attempt installation only when the current environment has network access and the Codex `skill-installer` script is available. Otherwise report the missing skill and continue with the bundled workflow's design rules unless the user explicitly requires those skills as a hard blocker.

Known install sources:

```powershell
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
python "$codexHome\skills\.system\skill-installer\scripts\install-skill-from-github.py" --repo Leonxlnx/taste-skill --path skills/taste-skill
python "$codexHome\skills\.system\skill-installer\scripts\install-skill-from-github.py" --repo nextlevelbuilder/ui-ux-pro-max-skill --path .claude/skills/ui-ux-pro-max
```

```bash
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
python3 "$CODEX_HOME_DIR/skills/.system/skill-installer/scripts/install-skill-from-github.py" --repo Leonxlnx/taste-skill --path skills/taste-skill
python3 "$CODEX_HOME_DIR/skills/.system/skill-installer/scripts/install-skill-from-github.py" --repo nextlevelbuilder/ui-ux-pro-max-skill --path .claude/skills/ui-ux-pro-max
```

After installing a new skill, tell the user to restart Codex before expecting automatic triggering. For the current run, manually read the installed skill file if it is readable.

## Hard Pre-Generation Gate

Before generating any HTML, CSS, JS, images, or evidence files, output these blocks:

```text
【工作流读取确认】
【执行环境检查】
【参考源检查】
【本次强制执行清单】
【设计执行卡】
【生成前确认摘要】
```

If company name, main business, valid contact method, city, or service area is missing, stop and ask the user. Do not generate the site. Do not use fake contact placeholders such as `400-000-0000`, `hello@example.com`, `contact@company.com`, or invented phone/email values.

Only continue with placeholder contact data when the user explicitly says placeholders are allowed. In that case, public pages must mark them clearly as `待补充`, and `_workflow/workflow-receipt.md` must quote or summarize the user's explicit permission. Evidence files must not claim placeholder permission unless it exists in the conversation.

## Default Public Navigation

Unless the user explicitly requests more first-level categories, use five top-level categories:

```text
首页
公司介绍
业务与方案
企业新闻
联系我们
```

For service-company sites, name the third category `服务与方案`. Combine service items, products/capabilities, solutions, scenarios, cases, and projects inside that third category instead of creating many first-level nav items by default.

Default page files for service-company static sites:

```text
index.html
about.html
services.html
news.html
contact.html
```

Keep top nav, footer links, sitemap, `llms.txt`, workflow receipt, design card, template conformance, and verification report aligned with the same structure.

## Design Boundaries

The bundled workflow chooses the site type, pages, image list, output structure, and AIO files. Design skills only improve visual execution.

Do not let design skills change:

- selected enterprise template type
- required page files
- required image count and filenames
- no-fake-news/customer/certificate rules
- output folder and static-site requirement
- `robots.txt`, `sitemap.xml`, `llms.txt`, `schema.jsonld`

The actual website quality comes first. Workflow receipts, manifests, and verification reports are evidence only. A site that has all evidence files but looks like a generic illustration landing page is a failed delivery.

## Color System

Follow the workflow's controlled palette system. Do not default to blue just because it is a B2B enterprise website.

Before generating files, lock one named palette in the design execution card:

```text
色板名称：
选择原因：
主色：
辅助色：
强调色：
背景色：
文字色：
禁用颜色：
主题色落位：
```

If choosing a blue palette, explain why blue is more appropriate than the non-blue options for this company.

Theme colors must appear in real UI positions, not only CSS variables. The accent color must appear in at least five of these positions: active nav state, H1 keyword highlight, primary CTA, secondary button hover/icon, section title rule, service/product card icon/index, image overlay/carousel dot/progress, stats strip, footer contact action/key link.

## Visual Quality

The generated site must feel like a real Chinese enterprise website, not a white card demo page.

- Use only the three bundled template directions by default: service industry, manufacturing industry, enterprise factory/industrial enterprise.
- Use a strong full-width first screen with real navigation.
- Use realistic or semi-realistic business/product/factory images. The hero image must not be flat illustration, abstract UI art, or chart-window graphics.
- Avoid pure white section after pure white section.
- Use full-width enterprise composition: hero, background bands, major image sections, carousel/banner areas, and footer should span the viewport.
- Preserve a coherent visual system across desktop and mobile.
- Implement restrained motion: reveal on scroll, staggered cards, hover states, sticky nav, back-to-top when useful, and `prefers-reduced-motion` support.
- Never fabricate real news, customer logos, certificates, exact metrics, awards, or partnership claims.
- Do not put workflow/checklist/compliance language inside public website pages.

## Completion Gate

Before claiming completion, perform evidence-based checks:

- all required HTML pages exist
- navigation links resolve
- CSS/JS/images resolve
- image count meets workflow minimums
- `assets/images/image-manifest.json` exists and explains each image
- `robots.txt`, `sitemap.xml`, `llms.txt`, `schema.jsonld` exist
- `_workflow/` contains workflow receipt, design card, reference check, template conformance
- `_verification/` contains desktop, tablet, mobile screenshots and verification report
- screenshots have been visually inspected
- no horizontal overflow
- locked palette is visibly applied in navigation, hero, CTA, cards/images, and footer
- no fake contact, customer, news, certificate, or award content

Report results under:

```text
【完成后验收】
```

