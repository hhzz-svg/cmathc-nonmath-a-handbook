= 两套模拟题及评分点

#import "settings.typ": *

#chapter_intro[
  两套模拟题用于训练时间分配、书写完整性和方法迁移。它们依据公开竞赛题风格重组或原创，不代表第十八届官方固定题型、题数或分值。
]

== 模拟题一：方法覆盖

建议用时 150 分钟。每题 10 分，评分重点是方法入口、条件说明和关键变形。

#exercise_set([M01-01], [求 $lim_(x -> 0)(e^x-1-x)/x^2$。])
#exercise_set([M01-02], [求 $integral_0^1 x/(1+x^2)d x$，并说明换元。])
#exercise_set([M01-03], [解 $y'-y=x$，且 $y(0)=0$。])
#exercise_set([M01-04], [在 $x^2+y^2<=1$ 上求 $x^2+y^2$ 的二重积分。])
#exercise_set([M01-05], [求 $sum_(n=1)^oo (x-1)^n/(n 2^n)$ 的收敛域。])
#exercise_set(
  [M01-06],
  [证明 $integral_0^1 f(x)d x<=1/2$，其中 $f(0)=0, |f'(x)|<=1$。],
)

== 模拟题二：综合迁移

建议用时 150 分钟。第二套不复用第一套的核心变形，解答页给关键步骤和评分点。

#exercise_set([M02-01], [讨论 $x^3-3x+a=0$ 的根的个数随 $a$ 的变化。])
#exercise_set(
  [M02-02],
  [交换 $integral_0^1 integral_x^1 g(y)d y d x$ 的积分次序并化简。],
)
#exercise_set([M02-03], [求点 $(1,1,1)$ 到平面 $x+y+z=0$ 的距离。])
#exercise_set([M02-04], [在 $x+y=1,x,y>=0$ 上求 $x^2+y^2$ 的最值。])
#exercise_set([M02-05], [求 $F=(x,y,z)$ 穿过半径 $R$ 球面的外向通量。])
#exercise_set([M02-06], [将 $f(x)=x$ 在 $(0,pi)$ 展开为 Fourier 正弦级数。])
