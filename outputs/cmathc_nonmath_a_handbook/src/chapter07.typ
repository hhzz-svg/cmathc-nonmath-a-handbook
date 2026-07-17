= 重积分、曲线积分与曲面积分

#import "settings.typ": *

#chapter_intro[
  本章的核心是区域、方向和换元。先画区域并辨认 Green、Gauss、Stokes 的适用场景，再计算积分；任何方向改变都必须同步检查符号。
]

== 方法框架
#method_card(
  [区域与换元],
  [积分区域由圆、椭圆、球面或不规则边界围成],
  [先画投影，再决定直角、极坐标、柱坐标或球坐标；Jacobian 与边界同时变换],
  [只换变量不换区域会得到看似整齐但错误的答案。],
)
#method_card(
  [Green/Gauss/Stokes],
  [曲线积分、通量或旋度/散度出现],
  [匹配公式左侧对象与右侧区域/曲面，并统一正向边界和外法向],
  [定向反转会改变符号；开曲线不能直接套闭曲线公式。],
)
#method_card(
  [路径无关],
  [积分结果只依赖端点或出现全微分形式],
  [检查旋度为零、区域单连通，或直接寻找势函数],
  [旋度为零在有洞区域不一定推出全局路径无关。],
)

== 精讲例题
#worked_example(
  "W07-01",
  "极坐标换元",
  "二重积分、Jacobian",
  "中",
  "12 min",
  "原创",
  [
    *题目：* 计算 $integral integral_(x^2+y^2<=1) (x^2+y^2) d x d y$。
    *解：* 令 $x=r cos theta,y=r sin theta$，区域为 $0<=r<=1,0<=theta<=2 pi$，Jacobian 为 $r$。积分为 $integral_0^(2pi)integral_0^1 r^3 d r d theta=pi/2$。
    *检查：* 被积函数的径向对称性和圆盘区域共同决定极坐标入口。
  ],
) <W07-01>
#worked_example(
  "W07-02",
  "三重积分的柱坐标",
  "三重积分、体积",
  "中高",
  "14 min",
  "原创",
  [
    *题目：* 求柱体 $x^2+y^2<=a^2,0<=z<=h$ 的体积。
    *解：* 柱坐标区域为 $0<=r<=a,0<=theta<=2 pi,0<=z<=h$，体积 $V=integral r d r d theta d z=pi a^2 h$。
    *提醒：* 柱坐标的 Jacobian 仍是 $r$；球坐标才会出现 $rho^2 sin phi$。
  ],
) <W07-02>
#worked_example(
  "W07-03",
  "Green 公式计算环流",
  "Green、方向",
  "高",
  "15 min",
  "原创",
  [
    *题目：* 逆时针闭曲线 $C$ 围成区域 $D$，求 $integral_C (-y d x+x d y)$。
    *解：* Green 公式给积分等于 $integral integral_D (partial_x x-partial_y(-y))d A=integral integral_D 2d A=2 A(D)$。
    *边界：* 若曲线顺时针，结果取负；公式方向约定不能省略。
  ],
) <W07-03>
#worked_example(
  "W07-04",
  "Gauss 公式求通量",
  "散度、闭曲面",
  "高",
  "15 min",
  "原创",
  [
    *题目：* 求向量场 $F=(x,y,z)$ 穿过球面 $x^2+y^2+z^2=R^2$ 的外向通量。
    *解：* $div F=3$。Gauss 公式把通量化为球内体积分 $integral integral integral 3 d V=3*4 pi R^3/3=4 pi R^3$。
    *比较：* 直接参数化球面更长；闭曲面且散度简单时优先 Gauss。
  ],
) <W07-04>
#worked_example(
  "W07-05",
  "路径无关与势函数",
  "线积分、势函数",
  "中高",
  "12 min",
  "原创",
  [
    *题目：* 判断 $P=2 x y,Q=x^2+2y$ 是否存在势函数，并求从 $(0,0)$ 到 $(1,1)$ 的线积分。
    *解：* $partial_y P=2x=partial_x Q$，且全平面单连通，故路径无关。势函数满足 $phi_x=2 x y$，得 $phi=x^2 y+g(y)$；由 $phi_y=x^2+g'(y)=Q$ 得 $g'(y)=2y$，取 $g=y^2$。
    因此积分为 $phi(1, 1)-phi(0, 0)=2$。
  ],
) <W07-05>
#worked_example(
  "W07-06",
  "Stokes 公式与方向",
  "旋度、曲面定向",
  "高",
  "15 min",
  "原创",
  [
    *题目：* 设 $S$ 为上半球面，边界为赤道逆时针方向，计算 $integral_(partial S) F dot d r$，其中 $F=(-y,x,0)$。
    *解：* $nabla times F=(0,0,2)$。由 Stokes 公式可用同边界的平面圆盘替代上半球，取向上法向，积分为 $integral integral_D 2 d A=2 pi R^2$。
    *关键：* 替换曲面必须保持同一边界和诱导方向，方向错置会使答案变号。
  ],
) <W07-06>

== 短例与章末训练
#quick_example(
  "Q07-01",
  "极坐标面积",
  [圆扇形面积为 $1/2 integral alpha^beta r^2 d theta$，边界函数先确定上下限。],
) <Q07-01>
#quick_example(
  "Q07-02",
  "Jacobian 绝对值",
  [换元公式使用 $|partial(x, y)/partial(u, v)|$；若映射分片一一对应，要分区相加。],
) <Q07-02>
#quick_example(
  "Q07-03",
  "通量方向",
  [外向法向与内向法向只差一个负号，但必须和公式的正向约定统一。],
) <Q07-03>
#quick_example(
  "Q07-04",
  "保守场快速判别",
  [全平面上 $P_y=Q_x$ 可推出路径无关；有洞区域需额外检查环路积分。],
) <Q07-04>
#exercise_set([X07-01--X07-04], [
  X07-01 用极坐标求单位圆盘上 $x^2+y^2$ 的积分。
  X07-02 用 Green 公式计算椭圆边界的环流。
  X07-03 用 Gauss 公式计算常向量场穿过闭曲面的通量。
  X07-04 判断给定平面场是否有势函数，并求一条折线路径上的积分。
])
