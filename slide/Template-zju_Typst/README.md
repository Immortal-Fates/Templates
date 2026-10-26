# 浙江大学 (ZJU) 学术论文分享 Typst Slide 模板

本项目是专为**学术论文分享、Seminar 研讨、组会汇报**打造的浙江大学风格幻灯片模板。基于 Typst 生态最主流的演示框架 `touying` 以及 `touying-simpl-sjtu` 深度重构，融合了浙大官方视觉标准（求是蓝 `#003f88`、校徽校标、背景纹样与四段式学术排版规范）。

---

## 核心特性

- **官方求是蓝品牌风格**：主色调采用浙江大学标准求是蓝（`#003f88`），提供浅色与深色（`title-slide-blue`, `end-slide-blue`）多套封面与结尾方案。
- **完整高校标识集成**：内置浙江大学校名书法题字、求是创新鹰标 Logo（包含黑标与反白白标版本）以及 16:9 高清背景纹理（引自 `Template-zju_Beamer/res`）。
- **学术论文分享专属组件**：
  - `problem-block`: 论文研究动机与退化困境（橙黄高亮）
  - `tldr-block`: 论文核心 Takeaway 与创新结论（求是蓝）
  - `method-block`: 算法模型架构与数学形式化表达（青绿标记）
  - `alert-block`: 局限性与批判性思考（深红警示）
  - `titled-block`: 通用带标题栏学术卡片（定理/定义/结论）
- **Beamer 经典导航体验**：支持顶部小球章节导航条（`mini-slides`）或侧边目录栏（`sidebar`），支持步进动画（`#pause`）。
- **秒级极速编译**：相比传统 LaTeX Beamer（需耗时十数秒且配置繁琐），Typst 享受毫秒级编译与即时预览。

---

## 文件结构

```text
Template-zju_Typst/
├── lib.typ          # ZJU 主题核心库与学术组件定义
├── main.typ         # 论文分享示例主文件 (以经典 ResNet 为示范)
├── main.pdf         # 编译生成的演示幻灯片 PDF
├── refs.bib         # 学术参考文献数据库
├── res/             # 浙大视觉资产目录
│   ├── zju_background.png     # 16:9 浅蓝背景底图
│   ├── zju_logo.png           # 浙大求是鹰圆形校徽 (原黑标)
│   ├── zju_logo_white.png     # 浙大求是鹰圆形校徽 (反白版)
│   ├── zju_title.png          # 浙江大学毛体校名 (原黑标)
│   └── zju_title_white.png    # 浙江大学毛体校名 (反白版)
└── README.md        # 使用文档与说明
```

---

## 快速使用

### 1. 编译幻灯片

在终端执行：

```bash
# 编译生成 PDF
typst compile main.typ main.pdf

# 开启实时监听 (修改即刻自动刷新预览)
typst watch main.typ
```

### 2. 基础配置示例

在你的 `.typ` 文档头部配置报告信息：

```typst
#import "@preview/touying:0.6.1": *
#import "lib.typ": *

#show: zju-theme.with(
  aspect-ratio: "16-9",          // 幻灯片比例 (推荐 16:9)
  navigation: "mini-slides",      // 顶部章节小球导航 ("mini-slides" / "sidebar" / none)
  config-info(
    title: [论文题目：Deep Residual Learning for Image Recognition],
    subtitle: [CVPR 2016 Best Paper · 文献精读与机制分享],
    author: [Kaiming He, Xiangyu Zhang, Shaoqing Ren, Jian Sun], // 原作者
    presenter: [汇报人姓名 (计算机科学与技术学院)],                // 分享汇报人
    institution: [浙江大学 · CAD&CG 国家重点实验室],
    date: datetime.today(),
  ),
  footer: self => [
    #self.info.at("presenter", default: self.info.author) · #self.info.title
  ],
)

// 首页封面
#title-slide()

// 目录页
#outline-slide()

// 正文章节
= 背景与动机
== 现有方法局限
...
```

---

## 学术组件语法说明

### 分栏对比 (Two-Column Layout)

```typst
#slide(composer: (1fr, 1fr))[
  #problem-block(title: [动机与挑战])[
    - 现有架构难以处理极深网络退化
  ]
][
  #tldr-block(title: [本文突破])[
    - 引入恒等残差跳连机制
  ]
]
```

### 步进动画 (Animation)

```typst
== 核心洞察
- 这一行在第一步显示
#pause
- 这一行在点击下一步后显示
```

### 参考文献引用

在正文中使用 `@citation_key` 引用 `refs.bib` 中的文献，并在结尾调用：

```typst
== 参考文献
#bibliography("refs.bib", title: none, style: "ieee")
```
