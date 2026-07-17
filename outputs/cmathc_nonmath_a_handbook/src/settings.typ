#let navy = rgb("20364f")
#let ink = rgb("26313a")
#let teal = rgb("2d6f73")
#let pale = rgb("eef3f5")
#let warm = rgb("f6f1e8")
#let line = rgb("c9d4da")

#set document(
  title: "全国大学生数学竞赛（非数学 A 类）备考手册",
  author: "备考手册编写项目",
  keywords: ("数学竞赛", "非数学 A 类", "高等数学"),
)
#set page(
  paper: "a4",
  margin: (top: 22mm, bottom: 19mm, left: 20mm, right: 20mm),
  header: context {
    if counter(page).get().first() > 1 {
      grid(
        columns: (1fr, auto),
        inset: (bottom: 5pt),
        stroke: (bottom: 0.5pt + line),
        text(size: 8.5pt, fill: navy)[全国大学生数学竞赛 · 非数学 A 类],
        text(size: 8.5pt, fill: navy)[高等数学初赛],
      )
    }
  },
  footer: context {
    if counter(page).get().first() > 1 {
      align(center, text(size: 8.5pt, fill: navy)[#counter(page).display()])
    }
  },
)
#set text(
  font: ("Microsoft YaHei", "Noto Sans SC"),
  size: 10.5pt,
  fill: ink,
  lang: "zh",
)
#set par(
  justify: true,
  leading: 0.55em,
  spacing: 0.7em,
)
#set heading(numbering: none)
#show heading.where(level: 1): h => block(
  breakable: false,
  above: 1.1em,
  below: 0.65em,
  fill: pale,
  inset: (x: 10pt, y: 7pt),
  radius: 2pt,
  stroke: (left: 3pt + navy),
  text(size: 17pt, weight: "bold", fill: navy)[#h.body],
)
#show heading.where(level: 2): h => block(
  above: 0.8em,
  below: 0.35em,
  text(size: 13pt, weight: "bold", fill: teal)[#h.body],
)
#show heading.where(level: 3): h => block(
  above: 0.55em,
  below: 0.25em,
  text(size: 11pt, weight: "bold", fill: navy)[#h.body],
)

#let tag(label, fill: navy) = box(
  fill: fill,
  radius: 2pt,
  inset: (x: 5pt, y: 2pt),
  text(size: 8.5pt, weight: "bold", fill: white)[#label],
)

#let callout(title, body, fill: pale, stroke: navy) = block(
  width: 100%,
  inset: 9pt,
  radius: 2pt,
  fill: fill,
  stroke: (left: 2pt + stroke),
  [
    #text(weight: "bold", fill: stroke)[#title] \
    #body
  ],
)

#let method_card(title, signal, action, caution) = callout(
  [方法卡 · #title],
  [
    *识别信号：* #signal \
    *核心操作：* #action \
    *边界提醒：* #caution
  ],
  fill: warm,
  stroke: teal,
)

#let worked_example(id, title, points, difficulty, time, source, body) = block(
  width: 100%,
  inset: (x: 10pt, y: 8pt),
  radius: 2pt,
  fill: white,
  stroke: (
    top: 1.2pt + navy,
    bottom: 0.5pt + line,
    left: 0.5pt + line,
    right: 0.5pt + line,
  ),
  [
    #text(size: 12pt, weight: "bold", fill: navy)[例题 #id · #title] \
    #text(
      size: 8.5pt,
      fill: teal,
    )[考点：#points　难度：#difficulty　建议用时：#time　来源：#source]
    #v(5pt)
    #body
  ],
)

#let quick_example(id, title, body) = block(
  width: 100%,
  inset: (x: 8pt, y: 6pt),
  radius: 2pt,
  fill: pale,
  stroke: 0.5pt + line,
  [#text(weight: "bold", fill: teal)[短例 #id · #title] #body],
)

#let exercise_set(title, body) = block(
  width: 100%,
  inset: (x: 9pt, y: 7pt),
  radius: 2pt,
  fill: rgb("fafafa"),
  stroke: (
    left: 2pt + teal,
    top: 0.5pt + line,
    bottom: 0.5pt + line,
    right: 0.5pt + line,
  ),
  [#text(weight: "bold", fill: teal)[训练 · #title] #body],
)

#let warning_box(title, body) = callout(
  [易错提醒 · #title],
  body,
  fill: rgb("fbf5e9"),
  stroke: rgb("a16b21"),
)

#let chapter_intro(text) = callout(
  [本章路线],
  text,
  fill: pale,
  stroke: navy,
)

#let blank = box(width: 100%, height: 1em, stroke: (bottom: 0.5pt + gray))[]
