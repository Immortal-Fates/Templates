# My Templates

一个用于集中记录和管理个人模板的仓库，包含：

- 文档模板（课程论文、实验报告、文献阅读报告）
- 幻灯片模板（Typst、LaTeX Beamer、PPTX、专业控制框图素材）
- 绘图图库（Draw.io 神经网络与模型库、Visio/SVG 框图）
- Prompt 模板（学习与论文阅读）
- 相关素材资源（logo、图片等）

## 项目结构

```text
.
├── assets/                    # 通用图片素材与 Logo
├── class-thesis/              # 课程论文模板（LaTeX、Markdown）
├── drawio/                    # 神经网络架构与绘图图库
├── prompt/                    # Prompt 模板与笔记
├── report/                    # 实验与学术报告模板（LaTeX、Markdown）
└── slide/                     # 演示幻灯片模板与工程框图素材
```

## 模板索引

### 1. Slide（幻灯片与矢量图素材）

- 浙江大学 Typst 学术分享模板  
  路径：[Template-zju_Typst](/Users/immortal/ws/docs/Templates/slide/Template-zju_Typst)  
  入口文件：`main.typ`  
  说明：基于 Touying 框架，专为组会研讨与学术分享设计，毫秒级极速编译。

- 浙江大学 Beamer 模板  
  路径：[Template-zju_Beamer](/Users/immortal/ws/docs/Templates/slide/Template-zju_Beamer)  
  入口文件：`ZJU_BeamerTemplate.tex`  
  说明：见目录内 `README.md`。

- 电气工程控制框图与拓扑素材（EE Control Figures）  
  路径：[slide](/Users/immortal/ws/docs/Templates/slide)  
  包含文件：
  1. `ee_ctrl_fig.pptx`：修复版现代 PPTX 格式，解除 OLE 服务锁定，双击不再报错，支持直接缩放、移动与取消组合。
  2. `ee_ctrl_fig.vsdx`：从源文件中独立提取的纯净 Microsoft Visio 原生图纸，支持直接在 Draw.io 或 Visio 中自由编辑。
  3. `ee_ctrl_fig_top.svg`：主拓扑框图的无损矢量 SVG，可导入 PPT 转换为原生图形对象。
  4. `ee_ctrl_fig.ppt`：原始 97-2003 格式母版文件。
  内容：VSC 变流器并网主电路、电流环、电压环、虚拟同步机（VSG）、附加频率控制、锁相环（PLL）、功率计算等矢量拓扑与框图。

- 汇报与图表素材 PPT  
  路径：`slide/template.pptx`、`slide/figs.pptx`

### 2. Report（实验/文献/课程报告）

- 学术文献阅读与提案报告模板（LaTeX）  
  路径：[reading-report-template](/Users/immortal/ws/docs/Templates/report/reading-report-template)  
  入口文件：`lxaiproposal.tex`  
  说明：IEEE 格式学术汇报与文献综述模板。

- 实验报告模板（LaTeX）  
  路径：[Template-实验报告](/Users/immortal/ws/docs/Templates/report/Template-实验报告)  
  入口文件：`main.tex`  
  示例输出：`main.pdf`

- 项目报告草稿（Markdown）  
  路径：`report/project/project.md`

### 3. Draw.io 绘图图库

- 神经网络架构 Draw.io 模板库  
  路径：[drawio-nn-templates](/Users/immortal/ws/docs/Templates/drawio/drawio-nn-templates)

- 深度学习模型图库  
  路径：[NN-Models-drawio-library](/Users/immortal/ws/docs/Templates/drawio/NN-Models-drawio-library)

### 4. Class Thesis（课程论文）

- 中文论文模板（LaTeX）  
  路径：[Template-中文论文](/Users/immortal/ws/docs/Templates/class-thesis/Template-中文论文)  
  入口文件：`thesis.tex`  
  示例输出：`CJC1.pdf`

- Markdown 论文模板（md-thesis）  
  路径：[md-thesis](/Users/immortal/ws/docs/Templates/class-thesis/md-thesis)  
  主要文件：`essay-template.md`、`cover-template.md`、`sample.md`

## Prompt 模板

- 基础 Prompt 笔记：`prompt/01-Basics.md`
- 模板集合：`prompt/02-Templates.md`

适用场景包括：

- 制定学习计划
- 深入理解论文章节
- 结构化笔记整理
- 多角色讨论与评审

## 常见问题与使用建议

### 1. PPT 中双击框图/公式报错“无法找到服务器应用程序、源文件、和项目”

- 报错根因：
  `ee_ctrl_fig.ppt` 为老版二进制 PPT，内部的顶层框图是嵌入的 Windows `Microsoft Visio Drawing` OLE 对象，公式为 `MathType 7.0` OLE 对象。在 macOS 或未安装对应软件的系统上，PowerPoint 尝试调用本地 OLE COM 服务器失败便会触发此报错。

- 修复与编辑方案：
  1. 框图编辑：建议直接使用提取好的 `slide/ee_ctrl_fig.vsdx`。推荐在本地或网页版 Draw.io（无需安装 Visio）中打开编辑，也可在 Windows Visio 中编辑；或使用 `slide/ee_ctrl_fig_top.svg` 插入 PPT 并点击“转换为形状”。
  2. PPT 浏览与排版：请打开修复后的 `slide/ee_ctrl_fig.pptx`。已解除 OLE 容器绑定，双击不再弹错，且保留全部矢量清晰度。
  3. 公式修改：macOS PowerPoint 已淘汰传统 OLE MathType，建议直接使用 PowerPoint 原生公式（快捷键 `Alt + =`，原生支持 LaTeX 语法，跨平台免环境依赖）。

### 2. 编译建议

1. Typst 模板使用 `typst compile main.typ` 或 `typst watch main.typ`，享受实时毫秒级预览。
2. LaTeX 模板建议安装 TeX Live，并优先使用 `XeLaTeX` 编译中文论文与报告。
3. Markdown 模板建议配合 Typora 使用以获得标准排版体验。
