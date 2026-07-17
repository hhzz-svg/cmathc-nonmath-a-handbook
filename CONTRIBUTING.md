# 贡献与复核指南

感谢维护这份面向后来者的备考资料。贡献时请优先保证数学正确性、官方范围边界和可复现构建。

## 修改题目

题目正文、答案和台账需要同步修改：

1. 在对应 `src/chapter*.typ` 或 `src/answers.typ` 中修改内容。
2. 在 `references/problem-ledger.csv` 中更新题目标题、范围 ID 和答案锚点。
3. 精讲题还要在 `references/math-review.csv` 中记录条件、端点、记号和复算状态。
4. 若题目涉及新的范围条目或动态事实，更新 `scope-matrix.csv`、`SOURCES.md` 或 `SOURCE_GAPS.md`。

不要把未经核实的动态信息写成确定的考试规则，也不要将线性代数重新绑定到非数学 A 类初赛正文。

## 修改排版

优先复用 `src/settings.typ` 中已有的组件。修改后检查长公式、表格、章节首页、答案页和索引页；不要用空白页、重复内容或异常拉伸来凑页数。

## 本地验收

在 `outputs/cmathc_nonmath_a_handbook` 目录执行：

```powershell
python -m pytest tests/test_checks.py -q
powershell -ExecutionPolicy Bypass -File .\build.ps1
typstyle --check src
```

验收目标是：PDF 95--110 页，题量为 `50/35/35/12`，内容检查通过，渲染图片数量等于 PDF 页数，且没有明显的公式截断、表格溢出或乱码。

## 提交说明

提交信息请说明业务变化，例如“补充广义积分端点判别例题”或“更新官方范围来源”。提交前附上测试命令和结果；如果修改了数学结论，请在描述中指出复算方式。

## 来源与版权

网络动态事实优先引用中国数学会官方来源。题目应使用原创、明确授权或可追溯的公开材料；不要直接复制未授权的整套试题或参考书内容。
