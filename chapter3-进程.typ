#import "@local/ysz_tools:0.1.0": *
#import "@preview/cuti:0.4.0": *
#show: show-cn-fakebold

#let pointbox(title: "重点与常识", body) = block(
  fill: rgb("#fff5f5"),
  stroke: (left: 4pt + rgb("#fa5252")),
  inset: 12pt,
  radius: 4pt,
  width: 100%,
  spacing: 1.5em,
  [
    #text(weight: "bold", fill: rgb("#c92a2a"))[#title] \
    #v(4pt)
    #body
  ],
)

#let img(path, caption: "", width: 80%, supplement: [图]) = {
  figure(
    image(path, width: width),
    caption: caption,
    supplement: supplement,
    kind: image,
  )
}
#show: conf.with(
  title: " OS note",
  author: "kiwiizzz & xhkzdepatedream & beigou9",
)
#show "（": "("
#show "）": ")"
#show ",": "，"
#show ":": "："

= 进程
#img("assets/chapter3/进程内存布局示意图.png", width: 100%, caption: [
  一个进程包括:代码段(text),程序计数器和处理机寄存器内容,栈,数据段
])

#table(
  columns: (auto, 1fr, 1fr),
  inset: 10pt,
  align: horizon,
  fill: (x, y) => if y == 0 { gray.lighten(80%) },
  stroke: 0.5pt + gray,

  [*对比维度*], [*程序 (Program)*], [*进程 (Process)*],

  [本质概念], [静态概念：指令的有序集合。], [动态概念：程序在处理机上的一次执行过程。],

  [存在形式], [可长久保存（如在硬盘上）。], [暂时的，有生命周期（创建→执行→暂停→消亡）。],

  [状态变化], [无状态变化，只是代码文件。], [是一个状态不断变化的过程（就绪、运行、阻塞等）。],

  [组成结构],
  [仅包含代码（指令）。],
  [进程映像 = 程序段 + 数据段 + 进程控制块 (PCB)。\ #emph[*(注：PCB是进程存在的唯一标志)*]],

  [对应关系],
  [一个程序可对应多个进程 \ #text(size: 8pt)[(例：打开多个Chrome窗口)]],
  [一个进程可包含多个程序 \ #text(size: 8pt)[(例：执行脚本时调用其他子程序)]],

  [主动性], [被动实体，不能主动创建新程序。], [主动实体，可以创建新进程 (如 `fork`)。],

  [资源视角], [不占用系统运行资源（仅在存储时占空间）。], [是资源分配和调度的基本单位（占用CPU、内存等）。],
)


#img("assets/chapter3/进程状态转换图.png", caption: [
  进程的状态
])

== 进程状态与转换
进程在执行时会不断改变状态，主要包括五种基本状态：新建、运行、等待（阻塞/睡眠）、就绪、终止。
- *就绪态*：已获得除CPU以外的所有资源，一旦分配了处理机就可以立即执行。
- *等待态（阻塞）*：由于发生某事件（如等待I/O）而暂时无法执行，即使分配CPU也无法运行。

#pointbox(title: "挂起状态 (Suspended)")[
  - 挂起也称*静止状态*，是被外界（OS或其它进程）强制剥夺执行权的被动状态。
  - 挂起的原因包括：系统故障修复、检查中间结果、资源不足、内存不足（换出到外存）。
]

== 进程控制块 (PCB)
#definition(title: "Process Control Block (PCB)")[
  - PCB是OS内核中描述和管理进程的数据结构，是进程实体的核心部分。
  - 操作系统通过PCB感知进程的存在，PCB是进程存在的唯一标志。
]
- *包含内容*：进程标识符、当前状态、队列指针、程序和数据地址、进程优先级、CPU现场保护区、通信信息、家族关系、资源清单等。
- *组织方式*：线性方式、链表方式（按状态组成就绪队列、阻塞队列等）、索引方式。
