#import "@preview/touying:0.6.1": *
#import "lib.typ": *

#show: zju-theme.with(
  aspect-ratio: "16-9",
  navigation: "mini-slides", // "mini-slides" 或 "sidebar" 或 none
  config-info(
    title: [Deep Residual Learning for Image Recognition],
    subtitle: [CVPR 2016 Best Paper · 学术论文精读与机制分享],
    author: [Kaiming He, Xiangyu Zhang, Shaoqing Ren, Jian Sun],
    presenter: [求是学子 (计算机科学与技术学院)],
    institution: [浙江大学 · CAD&CG 国家重点实验室],
    date: datetime.today(),
  ),
  footer: self => [
    #self.info.at("presenter", default: self.info.author) · #self.info.title
  ],
)

// 首页：论文分享封面
#title-slide()

// 目录页
#outline-slide()

= 背景与动机

== 网络深度与退化困境

#components.side-by-side(columns: (1.1fr, 0.9fr))[
  #problem-block(title: [网络加深带来的“退化问题” (Degradation)])[
    - *传统认知*：随着网络深度增加，特征表征能力更强，准确率理应持续提升。
    - *反直觉现象*：网络过深时，训练误差和测试误差*同时变大*，并非由过拟合导致。
    - *根本矛盾*：深层网络难以逼近“恒等映射” (Identity Mapping)。
  ]
][
  #tldr-block(title: [核心突破与直觉])[
    - *假设*：构造冗余层逼近 $cal(H)(bold(x)) = bold(x)$ 比从零学习复杂映射更容易。
    - *转变*：让残差函数 $cal(F)(bold(x)) = cal(H)(bold(x)) - bold(x)$ 去拟合零，从而消除退化。
  ]
]

== 经典网络演进与瓶颈

- *LeNet-5 (1998)*: 5 层卷积，手写数字识别基础架构。
- *AlexNet (2012)*: 8 层，ReLU + Dropout + GPU，拉开深度学习大幕。
- *VGGNet @simonyan2014very & GoogLeNet @szegedy2015going (2014)*: 16-22 层，深层堆叠导致梯度消失/爆炸与收敛困难。
- *ResNet @he2016deep (2015)*: 跨越至 152 层甚至 1202 层，彻底打破深度限制！

= 核心机制与架构

== 残差学习形式化定义

#method-block(title: [残差单元数学表达])[
  对于输入向量 $bold(x)$ 与目标期望映射 $cal(H)(bold(x))$，ResNet 不直接拟合 $cal(H)(bold(x))$，而是显式学习残差映射：
  $ cal(F)(bold(x), {W_i}) = cal(H)(bold(x)) - bold(x) $
  因此，整个残差单元的最终输出为：
  $ bold(y) = cal(F)(bold(x), {W_i}) + bold(x) $
]

#pause

- *Shortcut Connection (捷径连接)*：引入无参数恒等连接，不引入额外计算复杂度与显存开销。
- *反向传播优势*：误差反向传递时梯度的公式为 $frac(partial cal(E), partial bold(x)) = frac(partial cal(E), partial bold(y)) (frac(partial cal(F), partial bold(x)) + bold(I))$，恒有 $+bold(I)$ 项保证梯度通畅流动。

== BasicBlock 与 Bottleneck 结构对比

#components.side-by-side(columns: (1fr, 1fr))[
  #titled-block(title: [1. BasicBlock (用于 ResNet-18/34)])[
    - 连续两个 $3 times 3$ 卷积层堆叠
    - 结构清晰，参数量与计算复杂度适中：
    $ bold(x) -> "Conv" 3 times 3 -> "BN" -> "ReLU" -> "Conv" 3 times 3 -> "BN" plus.o bold(x) $
  ]
][
  #titled-block(title: [2. Bottleneck (用于 ResNet-50/101/152)])[
    - $1 times 1$ 降维 $->$ $3 times 3$ 标准卷积 $->$ $1 times 1$ 升维恢复通道
    - 极大减少浮点计算量 (FLOPs)：
    $ bold(x) -> "1x1 (降维)" -> "3x3" -> "1x1 (恢复)" plus.o bold(x) $
  ]
]

= 实验评估与分析

== ImageNet 评测结果

#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto),
    inset: 9pt,
    align: (left, center, center, center, center),
    stroke: (x, y) => if y == 0 { (bottom: 1.5pt + rgb("#003f88")) } else if y == 1 { (bottom: 1pt + rgb("#003f88")) } else { 0.5pt + rgb("#e0e0e0") },
    table.header([*模型架构*], [*网络层数*], [*Top-1 错误率 (%)*], [*Top-5 错误率 (%)*], [*FLOPs ($10^9$)*]),
    [VGG-16], [16], [28.07], [9.33], [15.3],
    [GoogLeNet], [22], [-], [9.15], [1.5],
    [Plain-34 (无残差)], [34], [28.54], [10.02], [3.6],
    [ResNet-34], [34], [25.03], [7.76], [3.6],
    [ResNet-50], [50], [22.85], [6.71], [3.8],
    [ResNet-101], [101], [21.75], [6.05], [7.6],
    [*ResNet-152*], [*152*], [*21.43*], [*5.71*], [*11.3*],
  )
]

- Plain 网络中，34 层表现明显劣于 18 层；而在 ResNet 中，34 层比 18 层错误率显著下降 2.8%。
- ResNet-152 斩获 ILSVRC 2015 分类、检测与定位三项冠军！

= 批判性思考与启示

== 优势、假设与局限

#components.side-by-side(columns: (1fr, 1fr))[
  #tldr-block(title: [主要优势与贡献])[
    - *优雅解耦*：通过残差重参数化彻底解决了深度优化困境。
    - *通用基础设施*：成为现代视觉、跨模态与甚至 Transformer (Pre/Post-LN 残差) 的通用标准组件。
  ]
][
  #alert-block(title: [潜在局限与思考])[
    - *有效深度的质疑*：后续研究 (如 Veit et al.) 发现 ResNet 某种程度上表现为多个浅层子网络的集成 (Ensemble)。
    - *特征重用瓶颈*：逐元素加法可能导致特征信息被稀释，DenseNet 通过通道拼接提供了另一解法。
  ]
]

== 参考文献

#bibliography("refs.bib", title: none, style: "ieee")

// 结束页
#end-slide[
  感谢各位老师与同学聆听！
  
  #text(size: 0.7em, fill: rgb("#003f88"))[Q & A / 欢迎交流与探讨]
]
