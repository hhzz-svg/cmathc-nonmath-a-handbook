# 全国大学生数学竞赛（非数学 A 类）备考手册

这是一个面向非数学专业 A 类初赛考生的开放备考项目。仓库同时保存可编辑的 Typst 源码、范围与题目台账、自动检查脚本、全页预览和已经编译好的 PDF，方便后来者直接使用、复核和继续维护。

## 适合谁

- 想系统准备全国大学生数学竞赛非数学 A 类初赛的学生。
- 想从源码重新构建或改编手册的教师、助教和学习小组。
- 需要检查题目覆盖范围、答案锚点和排版结果的维护者。

## 直接使用

- [下载备考手册 PDF](outputs/cmathc_nonmath_a_handbook/output/全国大学生数学竞赛非数学A类备考手册.pdf)
- [查看质量验收报告](outputs/cmathc_nonmath_a_handbook/logs/QUALITY_REPORT.md)
- [查看官方来源与范围边界](outputs/cmathc_nonmath_a_handbook/SOURCES.md)

当前成品为 97 页，包含 50 道精讲例题、35 道技巧短例、35 道章末训练和 12 道模拟题。题目总量为 132 道。

## 从源码构建

要求：Typst 0.15.1 或兼容版本、Python 3.11+、PowerShell 5.1 或 PowerShell 7。

```powershell
cd outputs/cmathc_nonmath_a_handbook
python -m pip install -r requirements.txt
powershell -ExecutionPolicy Bypass -File .\build.ps1
```

构建脚本会依次执行 Typst 编译、页数检查、题量与范围检查、自动化验收和全页 PNG 渲染。主 PDF 输出到 `output/`，预览和质量日志输出到 `logs/`。

## 仓库结构

- `outputs/cmathc_nonmath_a_handbook/src/`：正文、答案、索引和参考资料的 Typst 源码。
- `outputs/cmathc_nonmath_a_handbook/references/`：范围矩阵、题目台账、精讲题复核和页数预算。
- `outputs/cmathc_nonmath_a_handbook/scripts/`：页数、内容和 PDF 渲染检查器。
- `outputs/cmathc_nonmath_a_handbook/tests/`：检查器的自动化测试。
- `docs/`：项目设计与实施记录。
- `progress.md`：按任务追加的施工和验收日志。

## 范围边界

第十八届竞赛官方通知确认：非数学专业类初赛考高等数学，线性代数属于决赛内容。因此本手册不把线性代数写入初赛正文。由于官方通知没有逐项列出高等数学细目，项目使用竞赛命题组 2022 年正式出版指南补充当前可核实的高等数学模块，并把这一信息缺口记录在 `outputs/cmathc_nonmath_a_handbook/SOURCE_GAPS.md`。

动态规则、考试安排和组别信息应以 `SOURCES.md` 中的中国数学会官方来源为准，不要把本仓库的模拟题结构当作官方题型或分值承诺。

## 继续维护

提交新题、修订答案或更新官方范围时，请同时更新正文、答案、对应 CSV 台账和来源说明，并运行：

```powershell
cd outputs/cmathc_nonmath_a_handbook
python -m pytest tests/test_checks.py -q
powershell -ExecutionPolicy Bypass -File .\build.ps1
```

数学内容和排版均通过后再提交变更。具体协作要求见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 项目记录

- [设计说明](docs/superpowers/specs/2026-07-17-cmathc-nonmath-a-handbook-design.md)
- [实施计划](docs/superpowers/plans/2026-07-17-cmathc-nonmath-a-handbook.md)
- [项目验收矩阵](outputs/cmathc_nonmath_a_handbook/PROJECT_PLAN.md)
