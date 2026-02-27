# My Templates

一个用于集中记录和管理个人模板的仓库，包含：

- 文档模板（课程论文、实验报告）
- 幻灯片模板（LaTeX Beamer）
- Prompt 模板（学习与论文阅读）
- 相关素材资源（logo、图片等）

## 项目结构

```text
.
├── assets/                    # 通用图片素材
├── notes/                     # 备注（当前为空）
├── manage/                    # 管理脚本/工具位（当前为空）
├── prompt/                    # Prompt 模板与笔记
└── output/                    # 各类可直接使用的模板成品
    ├── slide/
    ├── report/
    └── class-thesis/
```

## 模板索引

### 1. Slide（幻灯片）

- 浙江大学 Beamer 模板  
  路径：`output/slide/Template-zju_Beamer/`  
  入口文件：`ZJU_BeamerTemplate.tex`  
  说明：见 `output/slide/Template-zju_Beamer/README.md`

- 现成 PPT 文件  
  路径：`output/slide/template.pptx`、`output/slide/pics.pptx`

### 2. Report（实验/课程报告）

- 实验报告模板（LaTeX）  
  路径：`output/report/Template-实验报告/`  
  入口文件：`main.tex`  
  示例输出：`main.pdf`

- 项目报告草稿（Markdown）  
  路径：`output/report/project/project.md`

### 3. Class Thesis（课程论文）

- 中文论文模板（LaTeX）  
  路径：`output/class-thesis/Template-中文论文/`  
  入口文件：`thesis.tex`  
  示例输出：`CJC1.pdf`

- Markdown 论文模板（md-thesis）  
  路径：`output/class-thesis/md-thesis/`  
  主要文件：`essay-template.md`、`cover-template.md`、`sample.md`

## Prompt 模板

- 基础 Prompt 笔记：`prompt/01-Basics.md`
- 模板集合：`prompt/02-Templates.md`

适用场景包括：

- 制定学习计划
- 深入理解论文章节
- 结构化笔记整理
- 多角色讨论与评审

## 使用建议

1. LaTeX 模板建议安装 TeX Live，并优先使用 `XeLaTeX` 编译（尤其是中文模板）。
2. Markdown 模板可配合 Typora 使用，以获得更稳定的表格与公式排版体验。
3. 新增模板时，建议按 `output/<category>/<template-name>/` 的目录规范归档。

## 维护约定

1. 每个模板目录尽量包含入口文件（如 `main.tex` / `thesis.tex` / `README.md`）。
2. 编译产物（PDF、aux、log）可按需保留；若仓库变大，可后续统一清理策略。
3. `assets/` 保持通用资源，模板私有资源放在各自子目录中。
