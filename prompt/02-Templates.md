

# Prompt Templates

[TOC]

## For better prompt

Reverse engineer out conversation and write the single prompt that would have produced my final response in one go.



## High-Quality Study Resources

I am learning **[topic]** and I want the study plan formatted as a **Typora-optimized markdown table** with the following columns:

- Date
- Topics (allow multiline using `<br>` within the cell)
- Readings (each reading should be a separate line with a link)

Please generate:

1. A multi-week study plan organized by date.
2. For each date, include **specific, scoped topics**, written concisely and using `<br>` for line breaks.
3. For each topic, select **high-quality readings from authoritative global sources only** (arXiv, top-tier conferences such as NeurIPS/ICLR/CVPR, MIT/Stanford/CMU courses, reputable textbooks, or well-regarded blogs).
4. For each reading, include both the **title** and a **direct link**.
5. Format the final output strictly as a **markdown table**, similar to the example below:

| Date | Topics                                                       | Readings                                                     |
| ---- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 2/4  | **Week 1: Introduction** 1. Course syllabus and requirements 2. Introduction to AI and AI research | 1. [Foundations and Trends in Multimodal Machine Learning](https://arxiv.org/abs/2209.03430) 2. [Multimodal Machine Learning: A Survey and Taxonomy](https://arxiv.org/abs/1705.09406) |

Additional preferences:

- My background: **[your academic level]** Postgraduate students from one of the best schools in the world
- My duration constraints: **[e.g., 2 weeks / 1 month / flexible]**
- My learning goal: **[e.g., research-level understanding / practical mastery]** 

> Tips: Anything else you want, remember to chat more
>
> - Consider your level: you want a course or just some papers?
> - Whether it's theory or practical operation

## Deep Understanding of a Specific Section

I am studying the section **[Section Title or Topic]** from my study plan.
 Please provide:

1. A clear, graduate-level explanation of the concepts, including definitions, key ideas, and intuitive interpretations.
2. A structured breakdown of the topic into its essential components.
3. Concrete examples to illustrate each major concept.
4. If the topic is technical, include relevant formulas, diagrams (mermaid if needed), or pseudocode.
5. A comparison to related concepts when helpful.
6. The typical pitfalls or misunderstandings students have about this topic.
7. Questions I should be able to answer after studying this section (self-assessment checklist).
8. If applicable, mini-exercises that strengthen understanding.
9. Optional: advanced or research-oriented extensions for deeper study.

Answer in a clear, professional, and concise structure suitable for a graduate-level learner.

## Notebook

introduce the [section] in the following way - Takeaway - Motivation - Core Mechanism - Pipeline - Pros - Cons

summarize they in English and lay they in typora format like this

- Takeaway (in one or two sentence)

- Motivation

...

and show out the math formula



## Discussion Roles

Scientific Peer Reviewer. The paper has not been published yet and is currently submitted to a top conference where you’ve been assigned as a peer reviewer. Complete a full review of the paper answering all prompts of the official review form of the top venue in this research area (e.g., NeurIPS). This includes recommending whether to accept or reject the paper

Academic Researcher. You’re a researcher who is working on a new project in this area. Propose an imaginary follow-up project not just based on the current but only possible due to the existence and success of the current paper.

Hacker. You’re a hacker who needs a demo of this paper ASAP. Implement a small part orsimplified version of the paper on a small dataset or toy problem. Prepare to share the core code of the algorithm to the class and demo your implementation. Do not simply download and run an existing implementation – though you are welcome to use (and give credit to) an existing implementation for “backbone” code.

## 给傻子（我）用的

我是一名智力低下的博士生，我想学习一下这篇论文/文献/资料，请用傻子都能懂的语言详细给我讲一下这篇论文/文献/资料怎么做的，特别是模型和实证方面

## 新领域寻找知识导图

你是我的知识结构调研助手。我想学习RL，具体关注RL的发展脉络。我的背景或学习目标是AI博士，有较好的数学素养。

请先在网上寻找别人已经整理好的相关知识结构材料，再分析他们如何组织知识。重点寻找：

- Knowledge map、mind map、concept map、知识图谱
- Whiteboard、visual notes、课程路线图、学习路径图
- XMind、Miro、FigJam、Excalidraw、Heptabase 等平台上的公开作品

请用中英文关键词检索，并优先提供**原作者或原始发布页面**，例如高校课程、研究团队、领域专家、开源项目和公开白板。不要只给我自行生成的知识导图，也不要把普通文章误当成导图。若无法确认某个材料确实存在或可以访问，请明确说明，不要猜测或编造。

请按以下结构回答：

1. **推荐材料**：筛选 5–10 个最相关的结果，按相关性和参考价值排序。用表格列出材料名称、作者或发布方、形式、覆盖范围、是否可直接查看，以及原始链接。
2. **结构拆解**：对最值得参考的 2–3 个材料，说明它们如何划分主题、安排层级或学习顺序、表示概念间关系，以及用了什么视觉组织方式。
3. **组织思路比较**：总结这些材料的共同点和差异，并指出哪一种更适合【我的学习目标】。
4. **迁移建议**：基于这些材料，给出一份适用于【领域 / 主题】的知识组织框架，说明哪些结构值得借鉴、哪些内容需要结合我的目标调整。请把“来源中实际看到的结构”和“你据此提出的建议”区分开。
5. **检索补充**：如果找到的公开材料较少，说明检索局限，并给我 5 组更精准的中英文搜索词。

尽量附上可直接打开的原图、白板或项目页面；若只能找到截图，请提供截图出处和对应原文链接。所有事实性描述都应能从链接中核对。
