// 浙江大学 (ZJU) Touying 学术幻灯片主题
// 基于 touying-simpl-sjtu 架构重构，融合浙江大学视觉形象 (求是蓝 #003f88 与校徽校标)
// 专为学术论文精读与研讨汇报 (Paper Share / Seminar / Group Meeting) 优化

#import "@preview/touying:0.6.1": *

#let _typst-builtin-repeat = repeat

// 浙大官方品牌色彩定义
#let zju-colors = (
  primary: rgb("#003f88"),          // 浙大蓝 (求是蓝)
  primary-dark: rgb("#002756"),     // 深浙大蓝
  primary-light: rgb("#eef5fc"),    // 浅浙大蓝 (卡片/背景底色)
  secondary: rgb("#1d70b8"),        // 次级科技蓝
  accent: rgb("#c99700"),           // 学术金 (点缀强调)
  alert: rgb("#c02c38"),            // 警示/对比红
  neutral-darkest: rgb("#1f2328"),  // 正文文字深黑
  neutral-dark: rgb("#333333"),     // 次级正文灰
  neutral-light: rgb("#f6f8fa"),    // 浅灰背景
  neutral-lightest: rgb("#ffffff"), // 纯白
)

// 顶部 mini-slides 章节导航条 (基于 Touying 原生组件与 Beamer 经典圆点导航)
#let mini-slides(
  self: none,
  fill: rgb("#003f88"),
  alpha: 60%,
  display-section: false,
  display-subsection: true,
  linebreaks: true,
  short-heading: true,
) = components.mini-slides(
  self: self,
  fill: fill,
  alpha: alpha,
  display-section: display-section,
  display-subsection: display-subsection,
  linebreaks: linebreaks,
  short-heading: short-heading,
)

// 页眉组件：上方小节圆点导航，下方小节标题、浙大双Logo与分隔横线
#let zju-header(self) = {
  let logo-box = grid(
    columns: (auto, auto),
    gutter: 0.5em,
    align: horizon,
    image("res/zju_title.png", height: 0.75cm),
    image("res/zju_logo.png", height: 0.75cm),
  )

  let title-bar = block(
    width: 100%,
    inset: (x: 1.8em, top: 0.2em),
    [
      #grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        text(
          fill: self.colors.primary,
          size: 1.15em,
          weight: "bold",
          utils.display-current-heading(level: 2),
        ),
        logo-box,
      )
      #v(0.4em)
      #line(length: 100%, stroke: (paint: self.colors.primary, thickness: 1.5pt))
    ]
  )

  if self.store.navigation == "sidebar" {
    place(right + top, {
      v(4em)
      show: block.with(width: self.store.sidebar.width, inset: (x: 1em))
      set align(left)
      set par(justify: false)
      set text(size: .9em)
      components.custom-progressive-outline(
        self: self,
        level: auto,
        alpha: self.store.alpha,
        text-fill: (self.colors.primary, self.colors.neutral-darkest),
        text-size: (1em, .9em),
        vspace: (-.2em,),
        indent: (0em, self.store.sidebar.at("indent", default: .5em)),
        fill: (self.store.sidebar.at("fill", default: _typst-builtin-repeat[.]),),
        filled: (self.store.sidebar.at("filled", default: false),),
        paged: (self.store.sidebar.at("paged", default: false),),
        short-heading: self.store.sidebar.at("short-heading", default: true),
      )
    })
  } else if self.store.navigation == "mini-slides" {
    mini-slides(
      self: self,
      fill: self.colors.primary,
      alpha: self.store.alpha,
      display-section: self.store.mini-slides.at("display-section", default: false),
      display-subsection: self.store.mini-slides.at("display-subsection", default: true),
      linebreaks: self.store.mini-slides.at("linebreaks", default: true),
      short-heading: self.store.mini-slides.at("short-heading", default: true),
    )
    title-bar
  } else {
    block(inset: (top: 0.6em), title-bar)
  }
}

// 页脚组件：左侧汇报信息/短标题，右侧页码
#let zju-footer(self) = {
  set align(bottom)
  set text(size: if self.appendix { 0em } else { 0.75em })
  show: pad.with(0.4em)
  components.left-and-right(
    block(inset: (left: 0.8em, bottom: 0.4em), text(
      fill: self.colors.neutral-darkest.lighten(35%),
      utils.call-or-display(self, self.store.footer),
    )),
    block(inset: (right: 0.8em, bottom: 0.4em), text(
      fill: self.colors.neutral-darkest.lighten(20%),
      weight: "medium",
      utils.call-or-display(self, self.store.footer-right),
    )),
  )
}

// 正文幻灯片基础包装
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(header: zju-header, footer: zju-footer, margin: (x: 2.2cm, top: 5.6em, bottom: 2.5em)),
    config-common(subslide-preamble: self.store.subslide-preamble),
  )
  touying-slide(self: self, config: config, repeat: repeat, setting: setting, composer: composer, ..bodies)
})

// 封面幻灯片：支持学术论文原作者、汇报人、发表期刊/会议信息
#let title-slide(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config, config-common(freeze-slide-counter: true), config-page(
    header: align(right + horizon, block(
      inset: (right: 1.5em, top: 1em),
      grid(
        columns: (auto, auto),
        gutter: 0.6em,
        align: horizon,
        image("res/zju_title.png", height: 1.1cm),
        image("res/zju_logo.png", height: 1.1cm),
      ),
    )),
    margin: (top: 3.5em, bottom: 1.5em, x: 2.5em),
    background: image("res/zju_background.png", width: 100%, height: 100%, fit: "cover"),
  ))
  let info = self.info + args.named()
  let body = {
    set par(leading: 1.3em)
    set align(center + horizon)
    block(width: 100%, inset: (x: 2em, y: 1em), {
      // 论文主标题
      block(
        text(
          size: if info.subtitle == none { 2.1em } else { 1.8em },
          fill: self.colors.primary,
          weight: "bold",
          info.title,
        )
      )
      // 论文副标题 / 会议期刊 (Venue)
      if info.subtitle != none {
        v(0.6em)
        block(
          text(
            size: 1.15em,
            fill: self.colors.primary-dark,
            weight: "semibold",
            info.subtitle,
          )
        )
      }
      
      v(1.6em)
      
      // 学术分享核心信息：原作者、汇报人、单位、日期
      align(center, block(
        width: 85%,
        stroke: 0.5pt + self.colors.primary.lighten(70%),
        fill: rgb("#ffffff").transparentize(15%),
        radius: 6pt,
        inset: 1.2em,
        {
          set text(size: 0.9em, fill: self.colors.neutral-darkest)
          let items = ()
          if info.author != none {
            items.push(text(weight: "bold", fill: self.colors.primary, [论文作者：]))
            items.push(info.author)
          }
          if info.at("presenter", default: info.at("reporter", default: none)) != none {
            items.push(text(weight: "bold", fill: self.colors.primary, [汇报分享：]))
            items.push(info.at("presenter", default: info.at("reporter", default: none)))
          }
          if info.institution != none {
            items.push(text(weight: "bold", fill: self.colors.primary, [培养单位：]))
            items.push(info.institution)
          }
          if info.date != none {
            items.push(text(weight: "bold", fill: self.colors.primary, [报告日期：]))
            items.push(utils.display-info-date(self))
          }
          grid(
            columns: (auto, 1fr),
            row-gutter: 0.7em,
            column-gutter: 1.2em,
            align: (right, left),
            ..items,
          )
        }
      ))
      
      if extra != none {
        v(0.8em)
        block(text(size: 0.8em, fill: self.colors.neutral-dark, extra))
      }
    })
  }
  touying-slide(self: self, body)
})

// 深色封面变体：浙大深蓝科技感
#let title-slide-blue(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config, config-common(freeze-slide-counter: true), config-page(
    fill: self.colors.primary-dark,
    margin: (top: 3em, bottom: 2em, x: 3em),
  ))
  let info = self.info + args.named()
  let body = {
    set align(left + horizon)
    set text(fill: white)
    grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      image("res/zju_title_white.png", height: 1.2cm),
      image("res/zju_logo_white.png", height: 1.2cm),
    )
    v(1.5em)
    line(length: 100%, stroke: 1.5pt + self.colors.secondary)
    v(1em)
    text(size: 2em, weight: "bold", info.title)
    if info.subtitle != none {
      v(0.6em)
      text(size: 1.2em, fill: white.darken(10%), weight: "medium", info.subtitle)
    }
    v(1.5em)
    let items = ()
    if info.author != none {
      items.push(text(fill: white.darken(20%), [论文作者:]))
      items.push(info.author)
    }
    if info.at("presenter", default: info.at("reporter", default: none)) != none {
      items.push(text(fill: white.darken(20%), [汇报人:]))
      items.push(info.at("presenter", default: info.at("reporter", default: none)))
    }
    if info.institution != none {
      items.push(text(fill: white.darken(20%), [所属机构:]))
      items.push(info.institution)
    }
    if info.date != none {
      items.push(text(fill: white.darken(20%), [日期:]))
      items.push(utils.display-info-date(self))
    }
    grid(
      columns: (auto, 1fr),
      row-gutter: 0.6em,
      column-gutter: 1.2em,
      align: (right, left),
      ..items,
    )
    if extra != none {
      v(1em)
      text(size: 0.8em, fill: white.darken(20%), extra)
    }
  }
  touying-slide(self: self, body)
})

// 目录幻灯片
#let outline-slide(config: (:), title: utils.i18n-outline-title, ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-common(freeze-slide-counter: true), config-page(
    footer: zju-footer,
    margin: (top: 4.5em, bottom: 2.5em, x: 3.5cm),
  ))
  touying-slide(self: self, config: config, components.adaptive-columns(
    start: text(1.7em, fill: self.colors.primary, weight: "bold", utils.call-or-display(self, title)),
    text(fill: self.colors.neutral-darkest, outline(title: none, indent: 1.2em, depth: self.slide-level, ..args)),
  ))
})

// 焦点幻灯片 (强调结论、关键洞察或 Q&A)
#let focus-slide(config: (:), body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-common(freeze-slide-counter: true), config-page(
    fill: self.colors.primary,
    margin: 2em,
  ))
  set text(fill: self.colors.neutral-lightest, size: 1.5em)
  touying-slide(self: self, config: config, align(horizon + center, body))
})

// 结束页：求是蓝底色卡片 + 校标校名
#let end-slide(config: (:), body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-common(freeze-slide-counter: true, new-section-slide-fn: none), config-page(
    margin: 2em,
    background: image("res/zju_background.png", width: 100%, height: 100%, fit: "cover"),
  ))
  set text(fill: self.colors.primary, size: 1.7em, weight: "bold")
  let body-content = {
    align(center + horizon, block(
      fill: rgb("#ffffff").transparentize(10%),
      stroke: 1pt + self.colors.primary.lighten(60%),
      radius: 8pt,
      inset: (x: 3em, y: 2.5em),
      stack(
        spacing: 1.5em,
        grid(
          columns: (auto, auto),
          gutter: 1em,
          align: horizon,
          image("res/zju_title.png", height: 1.5cm),
          image("res/zju_logo.png", height: 1.5cm),
        ),
        line(length: 60%, stroke: 1.5pt + self.colors.primary),
        body,
      )
    ))
  }
  touying-slide(self: self, config: config, body-content)
})

// 结束页变体 (深色版)
#let end-slide-blue(config: (:), body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-common(freeze-slide-counter: true), config-page(
    fill: self.colors.primary-dark,
    margin: 2em,
  ))
  set text(fill: white, size: 1.8em, weight: "bold")
  let body-content = {
    align(center + horizon, stack(
      spacing: 1.5em,
      grid(
        columns: (auto, auto),
        gutter: 1em,
        align: horizon,
        image("res/zju_title_white.png", height: 1.5cm),
        image("res/zju_logo_white.png", height: 1.5cm),
      ),
      line(length: 50%, stroke: 1.5pt + self.colors.secondary),
      body,
    ))
  }
  touying-slide(self: self, config: config, body-content)
})

// ────── 学术论文分享定制容器组件 ──────

// 带标题栏的通用内容块 (定理/定义/结论/要点)
#let titled-block(
  title: none,
  fill: rgb("#eef5fc"),
  stroke: rgb("#003f88"),
  radius: 4pt,
  body
) = {
  block(
    width: 100%,
    stroke: 0.8pt + stroke,
    radius: radius,
    clip: true,
    [
      #if title != none {
        block(
          width: 100%,
          fill: stroke,
          inset: (x: 0.8em, y: 0.45em),
          text(fill: white, weight: "bold", size: 0.9em, title),
        )
      }
      #block(
        width: 100%,
        fill: fill,
        inset: (x: 0.8em, y: 0.6em),
        text(fill: rgb("#1f2328"), body),
      )
    ]
  )
}

// 核心 Takeaway / 总结块
#let tldr-block(title: [Takeaway / 核心贡献], body) = titled-block(
  title: title,
  fill: rgb("#f0f7ff"),
  stroke: rgb("#003f88"),
  body
)

// 问题与动机块 (Problem / Motivation)
#let problem-block(title: [Motivation & Problem / 动机与挑战], body) = titled-block(
  title: title,
  fill: rgb("#fff8f0"),
  stroke: rgb("#c96a00"),
  body
)

// 核心方法块 (Method / Architecture)
#let method-block(title: [Method & Formulation / 核心方法], body) = titled-block(
  title: title,
  fill: rgb("#f0fbf6"),
  stroke: rgb("#0c7c59"),
  body
)

// 局限与批判性思考块 (Limitation / Critical Discussion)
#let alert-block(title: [Limitations & Discussion / 局限与思考], body) = titled-block(
  title: title,
  fill: rgb("#fff2f2"),
  stroke: rgb("#c02c38"),
  body
)

// 浙大学术幻灯片主题入口
#let zju-theme(
  aspect-ratio: "16-9",
  navigation: "mini-slides",
  font: (
    "PingFang SC",
    "Heiti SC",
    "Helvetica Neue",
    "Arial",
  ),
  sidebar: (
    width: 10em,
    filled: false,
    numbered: false,
    indent: .5em,
    short-heading: true,
  ),
  mini-slides: (
    height: 4em,
    x: 2em,
    display-section: false,
    display-subsection: true,
    linebreaks: false,
    short-heading: true,
  ),
  footer: none,
  footer-right: context utils.slide-counter.display() + " / " + utils.last-slide-number,
  primary: rgb("#003f88"), // 浙大求是蓝
  alpha: 40%,
  subslide-preamble: none,
  ..args,
  body,
) = {
  sidebar = utils.merge-dicts(
    (width: 10em, filled: false, numbered: false, indent: .5em, short-heading: true),
    sidebar,
  )
  mini-slides = utils.merge-dicts(
    (height: 4em, x: 2em, display-section: false, display-subsection: true, linebreaks: true, short-heading: true),
    mini-slides,
  )
  set text(size: 18pt)
  set par(justify: true)

  show: touying-slides.with(
    config-page(paper: "presentation-" + aspect-ratio, header-ascent: 1.5em, footer-descent: 0em, margin: if navigation
      == "sidebar" {
      (top: 2em, bottom: 1em, x: sidebar.width)
    } else if navigation == "mini-slides" {
      (top: if mini-slides.linebreaks { mini-slides.height } else { 5.2em }, bottom: 3em, x: mini-slides.x)
    } else {
      (top: 5em, bottom: 2em, x: mini-slides.x)
    }),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: none,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: font)
        show heading: set text(self.colors.primary)
        show outline.entry: set block(above: 1em)
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      neutral-darkest: rgb("#1f2328"),
      neutral-dark: rgb("#333333"),
      neutral-light: rgb("#f6f8fa"),
      neutral-lightest: rgb("#ffffff"),
      primary: primary,
    ),
    // save the variables for later use
    config-store(
      navigation: navigation,
      sidebar: sidebar,
      mini-slides: mini-slides,
      footer: footer,
      footer-right: footer-right,
      alpha: alpha,
      subslide-preamble: subslide-preamble,
    ),
    ..args,
  )

  body
}
