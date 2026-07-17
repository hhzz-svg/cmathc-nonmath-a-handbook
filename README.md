<div align="center">

# CMathC NonMath A Handbook

## 全国大学生数学竞赛（非数学专业 A 类）备考手册

**例题精讲 · 解题技巧 · 章末训练 · 模拟试题 · 公式速查 · Typst 源码**

[![PDF](https://img.shields.io/badge/PDF-97%20pages-2563eb?style=flat-square)](outputs/cmathc_nonmath_a_handbook/output/全国大学生数学竞赛非数学A类备考手册.pdf?raw=1)
[![Problems](https://img.shields.io/badge/problems-132-16a34a?style=flat-square)](#内容概览)
[![Typst](https://img.shields.io/badge/built%20with-Typst-239DAD?style=flat-square)](https://typst.app/)
[![Last commit](https://img.shields.io/github/last-commit/hhzz-svg/cmathc-nonmath-a-handbook?style=flat-square)](https://github.com/hhzz-svg/cmathc-nonmath-a-handbook/commits/main)

[下载最新版 PDF](outputs/cmathc_nonmath_a_handbook/output/全国大学生数学竞赛非数学A类备考手册.pdf?raw=1)
· [查看质量报告](outputs/cmathc_nonmath_a_handbook/logs/QUALITY_REPORT.md)
· [查看官方来源](outputs/cmathc_nonmath_a_handbook/SOURCES.md)
· [参与贡献](CONTRIBUTING.md)

</div>

---

这是一套面向 **全国大学生数学竞赛（CMathC）非数学专业 A 类初赛** 的开放备考资料。手册不按传统高等数学教材逐章重复定义，而是围绕竞赛中的高频题型、方法选择、解题技巧和规范书写组织内容。

仓库同时提供完整 PDF、可编辑 Typst 源码、题目与范围台账、自动化检查脚本和全页预览，适合参赛学生直接复习，也适合教师、助教和学习小组继续维护。

> English keywords: Chinese Mathematics Competitions, CMathC, National College Student Mathematics Competition, Non-Mathematics Category A, calculus competition handbook.

## 为什么做这个项目

非数学专业学生备赛时常见的问题不是“完全没学过”，而是：

- 会使用公式，但看不出竞赛题的结构信号；
- 知道多种方法，却不能迅速判断哪一种最合适；
- 证明题能想到方向，但写不出完整、可得分的过程；
- 真题和笔记很多，却缺少可以复查、持续修订的统一资料。

本项目尝试把这些内容整理成一套可构建、可检查、可扩展的公开手册。

## 内容概览

当前主手册共 **97 页、132 道题**：

| 类型 | 数量 | 作用 |
|---|---:|---|
| 精讲例题 | 50 | 展示观察、方法选择、完整解答与易错点 |
| 技巧短例 | 35 | 集中训练单一方法与快速识别 |
| 章末训练 | 35 | 检查章节掌握程度 |
| 模拟题 | 12 | 综合训练与限时测试 |

主要内容覆盖：

- 竞赛范围、备考安排与答题策略
- 极限与连续
- 导数、微分与中值定理
- 一元函数应用与不等式
- 不定积分、定积分与广义积分
- 多元函数微分学
- 重积分与变量代换
- 无穷级数及相关综合题
- 高频模型、易错点与考前速查

## 适合谁

- 准备参加全国大学生数学竞赛非数学专业 A 类初赛的本科生；
- 已学过高等数学，希望系统训练竞赛方法的学生；
- 需要组织竞赛辅导、习题课或学习小组的教师和助教；
- 希望复用 Typst 教材模板、题目台账和自动验收流程的维护者。

## 直接使用

### 下载主手册

- **[全国大学生数学竞赛非数学 A 类备考手册.pdf](outputs/cmathc_nonmath_a_handbook/output/全国大学生数学竞赛非数学A类备考手册.pdf?raw=1)**

### 阅读项目资料

- [质量验收报告](outputs/cmathc_nonmath_a_handbook/logs/QUALITY_REPORT.md)
- [官方来源与范围边界](outputs/cmathc_nonmath_a_handbook/SOURCES.md)
- [尚未完全核实的信息](outputs/cmathc_nonmath_a_handbook/SOURCE_GAPS.md)
- [项目验收矩阵](outputs/cmathc_nonmath_a_handbook/PROJECT_PLAN.md)
- [贡献与复核指南](CONTRIBUTING.md)

## 手册的编写原则

1. **例题与技巧优先。** 知识点只保留竞赛中真正需要的定义、条件和结论。
2. **强调方法判断。** 精讲题不仅给计算过程，还解释为什么选择该方法。
3. **明确范围边界。** 动态规则使用中国数学会官方信息核实，不能确认的内容单独记录。
4. **题目来源可追溯。** 题目标记为真题、真题改编、经典模型或原创，不伪称官方题目。
5. **构建过程可复现。** PDF、题量、答案覆盖和页面渲染均由脚本检查。
6. **不靠排版凑页数。** 不使用重复段落、大面积空白或异常字号增加篇幅。

## 从源码构建

### 环境要求

- Windows 10/11
- Typst 0.15.1 或兼容版本
- Python 3.11+
- PowerShell 5.1 或 PowerShell 7

### 一键构建

```powershell
cd outputs/cmathc_nonmath_a_handbook
python -m pip install -r requirements.txt
powershell -ExecutionPolicy Bypass -File .\build.ps1
```

构建脚本会依次执行：

1. Typst 编译；
2. 页数与题量检查；
3. 范围和答案覆盖检查；
4. 自动化测试；
5. PDF 全页 PNG 渲染；
6. 质量报告输出。

主 PDF 位于：

```text
outputs/cmathc_nonmath_a_handbook/output/全国大学生数学竞赛非数学A类备考手册.pdf
```

## 仓库结构

```text
.
├─ README.md
├─ CONTRIBUTING.md
├─ docs/                         # 项目设计与实施记录
├─ outputs/
│  └─ cmathc_nonmath_a_handbook/
│     ├─ src/                    # Typst 正文、答案、索引与排版组件
│     ├─ references/             # 范围矩阵、题目台账与复核记录
│     ├─ scripts/                # 页数、题量、重复内容与渲染检查
│     ├─ tests/                  # 自动化检查测试
│     ├─ output/                 # 编译后的 PDF
│     ├─ logs/                   # 质量报告与构建日志
│     ├─ SOURCES.md              # 官方来源与参考资料
│     └─ SOURCE_GAPS.md          # 待核实的信息缺口
└─ progress.md                   # 开发与验收记录
```

## 考试范围说明

第十八届竞赛官方通知确认：非数学专业类初赛考查高等数学，线性代数属于决赛内容。因此，本手册没有把线性代数写入初赛主体。

由于官方通知没有逐项列出全部高等数学细目，项目使用竞赛命题组正式出版的参赛指南补充模块边界，并在 `SOURCE_GAPS.md` 中记录仍需注意的信息缺口。

动态规则、竞赛时间、组别设置和考试安排应始终以 [SOURCES.md](outputs/cmathc_nonmath_a_handbook/SOURCES.md) 中列出的最新官方来源为准。本仓库的模拟题结构不代表官方固定题型或分值承诺。

## 参与贡献

欢迎提交：

- 数学错误修正；
- 更清晰或更简洁的解法；
- 题目条件、端点、参数范围和符号修订；
- 官方范围和来源更新；
- Typst 排版、构建脚本和质量检查改进；
- 新的原创例题与变式训练。

修改正文后，请同步更新题目台账、答案锚点和复核记录，并运行：

```powershell
cd outputs/cmathc_nonmath_a_handbook
python -m pytest tests/test_checks.py -q
powershell -ExecutionPolicy Bypass -File .\build.ps1
typstyle --check src
```

详细规范见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 项目记录

- [设计说明](docs/superpowers/specs/2026-07-17-cmathc-nonmath-a-handbook-design.md)
- [实施计划](docs/superpowers/plans/2026-07-17-cmathc-nonmath-a-handbook.md)
- [项目验收矩阵](outputs/cmathc_nonmath_a_handbook/PROJECT_PLAN.md)

## 免责声明

本项目是面向学习与交流的独立整理资料，不代表全国大学生数学竞赛官方立场。竞赛范围、报名安排和考试规则请以中国数学会及各赛区最新通知为准。

如果这份资料对你有帮助，可以 Star 仓库；发现错误时，请通过 Issue 或 Pull Request 提交可复核的修改说明。
