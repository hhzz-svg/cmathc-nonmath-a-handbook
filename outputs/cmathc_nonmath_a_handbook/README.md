# 全国大学生数学竞赛（非数学 A 类）备考手册

本目录包含《全国大学生数学竞赛（非数学 A 类）备考手册》的 Typst 源码、题目台账、范围映射、检查脚本和主 PDF。正文面向非数学专业 A 类初赛，按当前可核实的高等数学范围编写；线性代数不作为初赛正文内容。

## 构建环境

- Typst 0.15.1 或兼容版本
- Python 3.11 或更高版本
- PowerShell 5.1 或 PowerShell 7

安装 Python 检查依赖：

```powershell
python -m pip install -r requirements.txt
```

## 一键构建

在本目录执行：

```powershell
powershell -ExecutionPolicy Bypass -File .\build.ps1
```

脚本依次完成 Typst 编译、页数检查、题量与范围检查和全页 PNG 渲染。成功后主 PDF 位于：

```text
output\全国大学生数学竞赛非数学A类备考手册.pdf
```

全页预览位于 `logs\preview\`，质量验收记录位于 `logs\QUALITY_REPORT.md`。

## 目录说明

- `src\`：Typst 正文、答案、索引和参考资料。
- `references\`：范围矩阵、题目台账、精讲题复核台账和页数预算。
- `scripts\`：页数、内容和 PDF 渲染检查器。
- `tests\`：检查器自动化测试。
- `SOURCES.md`、`SOURCE_GAPS.md`：来源记录及当前官方细目缺口。
- `PROJECT_PLAN.md`：本交付版本的验收矩阵。

## 范围边界

第十八届竞赛通知确认非数学专业类初赛考试内容为高等数学，线性代数属于决赛科目。本手册采用竞赛命题组 2022 年正式出版指南补充高等数学逐项细目，并在 `SOURCE_GAPS.md` 记录“未发布单独逐项大纲”的信息缺口。动态规则以 `SOURCES.md` 中的中国数学会官方来源为准。

## 字体

Typst 会优先使用 Windows 常见中文字体。若本机缺少中文字体，安装 `Microsoft YaHei` 或 `SimSun` 后重新构建；PDF 中的中文和公式应保持可复制。
