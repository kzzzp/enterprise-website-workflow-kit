# 企业官网生成启动提示词

```text
使用 enterprise-website-delivery skill，根据下面公司简介生成一个中文企业官网静态 HTML 网站。

要求：
1. 读取 skill 内置的 references/enterprise-website-workflow.md。
2. 先判断是否缺少公司名称、主营业务、有效联系方式、城市或服务区域。
3. 缺少必要信息就先追问，不要直接生成占位联系方式。
4. 默认只使用工作流中的三套模板方向：服务行业、制造行业、企业工厂/工业企业。
5. 生成纯静态 HTML，不使用后端和数据库。
6. 必须生成多页面导航、真实感图片、AIO 文件、_workflow/、_verification/ 和 image-manifest.json。

公司简介如下：
【这里粘贴公司简介】
```

