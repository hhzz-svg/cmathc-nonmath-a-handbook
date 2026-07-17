# 项目验收矩阵

## 交付目标

本版本交付一份 95--110 页的非数学专业 A 类初赛备考手册，精讲题约 50 道且实际固定为 50 道，完整覆盖当前可核实的高等数学范围，并提供可复现的 Windows 构建与验收入口。

## 题量验收

| 类型 | 目标 | 实际 | 验证 |
| --- | ---: | ---: | --- |
| 精讲例题 | 50 | 50 | `python scripts/check_content.py .` |
| 技巧短例 | 35 | 35 | `python scripts/check_content.py .` |
| 章末训练 | 35 | 35 | `python scripts/check_content.py .` |
| 模拟题 | 12 | 12 | `python scripts/check_content.py .` |
| 总题量 | 132 | 132 | `python scripts/check_content.py .` |

## 范围验收

正文覆盖以下高等数学模块：

1. 函数、极限与连续。
2. 一元微分、中值定理与应用。
3. 一元积分及其应用。
4. 空间解析几何与常微分方程。
5. 多元函数微分学。
6. 重积分、曲线积分与曲面积分。
7. 无穷级数与 Fourier 级数。
8. 高等数学综合强化。

第 8 项是跨专题强化，不引入初赛范围外的新科目。线性代数仅在来源和边界说明中记录为决赛内容，不绑定初赛正文。

## 页数与导航验收

- 主 PDF：95--110 页，实际页数以 `scripts/check_page_count.py` 输出为准。
- 目录、章标题和答案锚点由 Typst 生成 PDF 书签与内部链接。
- 全页渲染图片数量应等于 PDF 页数，联系表位于 `logs/preview/contact-sheet.png`。
- 视觉复核覆盖封面、章节首页、长公式、表格、模拟题、答案、索引和最后一页。

## 主要交付物

- `output/全国大学生数学竞赛非数学A类备考手册.pdf`
- `src/` 下全部可编辑 Typst 源文件。
- `references/` 下范围、题目、数学复核和页数台账。
- `README.md`、`SOURCES.md`、`SOURCE_GAPS.md`、`QUALITY_REPORT.md`。

## 验收命令

```powershell
python -m pytest tests/test_checks.py -q
powershell -ExecutionPolicy Bypass -File .\build.ps1
```
