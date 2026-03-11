#import "@local/ysz_tools:0.1.0": *
#import "@preview/cuti:0.4.0":*
#show:show-cn-fakebold

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
#show "（":"("
#show "）":")"
#show "；": ";"
= 进程
#img("assets/image-3.png",width:100%,caption:[
  一个进程包括:代码段(text),程序计数器和处理机寄存器内容,栈,数据段 
])

| 对比维度 | 程序 (Program) | 进程 (Process) |
| :--- | :--- | :--- |
| 本质概念 | 静态概念：指令的有序集合。 | 动态概念：程序在处理机上的一次执行过程。 |
| 存在形式 | 可长久保存（如在硬盘上）。 | 暂时的，有生命周期（创建→执行→暂停→消亡）。 |
| 状态变化 | 无状态变化，只是代码文件。 | 是一个状态不断变化的过程（就绪、运行、阻塞等）。 |
| 组成结构 | 仅包含代码（指令）。 | 进程映像 = 程序段 + 数据段 + 进程控制块 (PCB)。<br>*(注：PCB是进程存在的唯一标志)* |
| 对应关系 | 一个程序可对应多个进程<br>*(例：打开多个Chrome窗口，对应多个进程，但都是同一个程序)* | 一个进程可包含多个程序<br>*(例：执行脚本时调用其他子程序)* |
| 主动性 | 被动实体，不能主动创建新程序。 | 主动实体，可以创建新进程 (如 `fork`)。 |
| 资源视角 | 不占用系统运行资源（仅在存储时占空间）。 | 是资源分配和调度的基本单位（占用CPU、内存等）。 |
这是谁tm干的


#img("assets/image-4.png",caption:[
  进程的状态
])