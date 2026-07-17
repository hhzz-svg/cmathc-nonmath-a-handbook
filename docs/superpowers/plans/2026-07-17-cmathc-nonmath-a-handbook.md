# 全国大学生数学竞赛（非数学 A 类）备考手册 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 生成一套可在 Windows 一键构建、完整覆盖最新官方非数学专业 A 类范围、主 PDF 为 95--110 页且包含约 50 道精讲例题和不少于 120 道总题量的 Typst 备考手册。

**Architecture:** 项目放在 `outputs/cmathc_nonmath_a_handbook/`，以来源台账和官方范围映射驱动章节写作，以独立 Typst 章节文件组织内容，以 `settings.typ` 提供统一语义组件。Python 检查脚本负责页数、题量、索引、来源与数学复核台账的机器可检部分；最终通过全页渲染和人工数学复算完成验收。

**Tech Stack:** Typst、PowerShell 7/Windows PowerShell 5.1、Python 3.11+、pypdf、PyMuPDF、pytest。

## Global Constraints

- 工作区根目录：`C:/Users/huzhe/Documents/Codex/2026-07-17/files-mentioned-by-the-user-z`。
- 正式交付目录：`outputs/cmathc_nonmath_a_handbook/`；中间提取文本和渲染拼图放入根目录 `work/`。
- 主 PDF 页数为 95--110 页，排版目标为 104--108 页，不通过空白、重复定义或扩行距凑页。
- 内容完整覆盖制作时可核实的最新官方非数学专业 A 类范围；动态信息必须记录官方链接和 2026-07-17 或实际查询日期。
- 题量目标为 50 道精讲例题、35 道技巧短例、35 道章末训练和两套各 6 题模拟题，共 132 题。
- 50 道精讲例题逐题复算；所有题目均有答案、关键提示或完整解答。
- 附件《全国大学生数学竞赛参赛指南》（科学出版社，2022）只作为基础参考，不替代最新官方通知，不大段复制原书或整套官方试题。
- A4 纵向、中文和公式文本可复制、黑白打印可读、目录可点击、书签完整。
- 当前工作区不是 Git 仓库，不自行执行 `git init`；每项任务以 `progress.md` 追加记录作为检查点。
- 任何最新官方范围无法确认的条目必须进入 `SOURCE_GAPS.md`，且在范围确认前不得把该条目写成确定事实。

## File Map

### 项目级文件

- `outputs/cmathc_nonmath_a_handbook/README.md`：安装、构建、产物和目录说明。
- `outputs/cmathc_nonmath_a_handbook/PROJECT_PLAN.md`：页数、题量和章节验收矩阵。
- `outputs/cmathc_nonmath_a_handbook/SOURCES.md`：官方通知、附件指南、教材及题目来源台账。
- `outputs/cmathc_nonmath_a_handbook/SOURCE_GAPS.md`：未核实动态信息及其对正文的处理结果。
- `outputs/cmathc_nonmath_a_handbook/requirements.txt`：Python 检查与渲染依赖。
- `outputs/cmathc_nonmath_a_handbook/build.ps1`：单命令编译、检查和渲染入口。

### 数据与台账

- `outputs/cmathc_nonmath_a_handbook/references/scope-matrix.csv`：官方考点到章节和题目的完整映射。
- `outputs/cmathc_nonmath_a_handbook/references/problem-ledger.csv`：132 道题的编号、类型、来源属性和答案位置。
- `outputs/cmathc_nonmath_a_handbook/references/math-review.csv`：50 道精讲例题的复算状态和复核说明。
- `outputs/cmathc_nonmath_a_handbook/references/page-budget.csv`：章节页数预算和最终页码。

### Typst 源文件

- `outputs/cmathc_nonmath_a_handbook/src/main.typ`：文档元数据、目录、章节包含顺序和 PDF 入口。
- `outputs/cmathc_nonmath_a_handbook/src/settings.typ`：页面、字体、标题、页眉页脚和语义组件。
- `outputs/cmathc_nonmath_a_handbook/src/cover.typ`：封面、前言、使用说明和符号约定。
- `outputs/cmathc_nonmath_a_handbook/src/chapter01.typ`：竞赛概览、范围、诊断和备考策略。
- `outputs/cmathc_nonmath_a_handbook/src/chapter02.typ`：函数、极限与连续。
- `outputs/cmathc_nonmath_a_handbook/src/chapter03.typ`：一元微分、中值定理与应用。
- `outputs/cmathc_nonmath_a_handbook/src/chapter04.typ`：一元积分及其应用。
- `outputs/cmathc_nonmath_a_handbook/src/chapter05.typ`：向量与空间解析几何、常微分方程。
- `outputs/cmathc_nonmath_a_handbook/src/chapter06.typ`：多元函数微分学。
- `outputs/cmathc_nonmath_a_handbook/src/chapter07.typ`：重积分、曲线积分、曲面积分和场论公式。
- `outputs/cmathc_nonmath_a_handbook/src/chapter08.typ`：常数项级数、幂级数和 Fourier 级数。
- `outputs/cmathc_nonmath_a_handbook/src/chapter09.typ`：线性代数。
- `outputs/cmathc_nonmath_a_handbook/src/chapter10.typ`：综合证明与竞赛构造。
- `outputs/cmathc_nonmath_a_handbook/src/chapter11.typ`：高频模型、公式、易错点与考场清单。
- `outputs/cmathc_nonmath_a_handbook/src/chapter12.typ`：两套模拟题及评分点。
- `outputs/cmathc_nonmath_a_handbook/src/answers.typ`：短例、训练题和模拟题答案系统。
- `outputs/cmathc_nonmath_a_handbook/src/indexes.typ`：题目索引和技巧索引。
- `outputs/cmathc_nonmath_a_handbook/src/references.typ`：参考资料和动态信息查询说明。

### 检查与测试

- `outputs/cmathc_nonmath_a_handbook/scripts/check_page_count.py`：检查主 PDF 页数区间。
- `outputs/cmathc_nonmath_a_handbook/scripts/check_content.py`：检查题量、编号、答案、范围映射和复核状态。
- `outputs/cmathc_nonmath_a_handbook/scripts/render_preview.py`：将 PDF 全页渲染为 PNG 并生成联系表。
- `outputs/cmathc_nonmath_a_handbook/tests/test_checks.py`：检查脚本的自动化测试。
- `outputs/cmathc_nonmath_a_handbook/logs/QUALITY_REPORT.md`：最终机器检查与人工视觉检查证据。
- `outputs/cmathc_nonmath_a_handbook/output/全国大学生数学竞赛非数学A类备考手册.pdf`：主交付 PDF。

---

### Task 1: 核验最新官方范围并建立来源台账

**Files:**
- Create: `outputs/cmathc_nonmath_a_handbook/SOURCES.md`
- Create: `outputs/cmathc_nonmath_a_handbook/SOURCE_GAPS.md`
- Create: `outputs/cmathc_nonmath_a_handbook/references/scope-matrix.csv`
- Create: `outputs/cmathc_nonmath_a_handbook/references/problem-ledger.csv`
- Create: `outputs/cmathc_nonmath_a_handbook/references/math-review.csv`
- Create: `outputs/cmathc_nonmath_a_handbook/references/page-budget.csv`

**Interfaces:**
- Consumes: 附件 PDF 路径 `D:/课程资料/数学/竞赛/全国大学生数学竞赛参赛指南 (佘志坤) (z-library.sk, 1lib.sk, z-lib.sk).pdf`，中国数学会或竞赛官方发布的最新通知。
- Produces: 所有章节必须引用的范围条目 ID（`S-HM-*`、`S-LA-*`）和题目台账字段。

- [ ] **Step 1: 从附件指南提取非数学专业基础范围**

Run:

```powershell
pdftotext -enc UTF-8 -f 18 -l 24 -layout -- `
  'D:/课程资料/数学/竞赛/全国大学生数学竞赛参赛指南 (佘志坤) (z-library.sk, 1lib.sk, z-lib.sk).pdf' `
  'work/nonmath_scope_2022.txt'
```

Expected: `work/nonmath_scope_2022.txt` 包含“非数学专业类”“高等数学”“线性代数”及其分项范围；提取页码根据 PDF 实际前置页偏移调整一次，以文本标题为准。

- [ ] **Step 2: 查询最新官方通知并记录可追溯信息**

在 `SOURCES.md` 中为每条动态来源记录以下固定字段：标题、发布机构、发布日期、URL、查询日期、支持的事实、是否为第一方来源。至少找到一条能确认当前组别名称的官方材料和一条能确认考试范围的官方材料；如果同一份官方文件同时支持两项事实，可以只记录一条来源。

Expected: 每条“最新范围、比赛时间、组别规则”陈述都能指向 `SOURCES.md` 中的官方来源；搜索结果页、转载文章和论坛不能作为唯一依据。

- [ ] **Step 3: 建立范围映射 CSV**

Create `references/scope-matrix.csv` with this header:

```csv
scope_id,category,official_item,official_source,chapter,coverage_kind,content_id,verification_date,status
```

逐项写入官方范围。`coverage_kind` 只使用 `worked`、`quick`、`exercise`、`reference` 四个值；`status` 只使用 `verified` 或 `gap`。所有 `gap` 行同步写入 `SOURCE_GAPS.md`，不得绑定未编写的确定性正文。

- [ ] **Step 4: 建立题目与数学复核台账结构**

Create `references/problem-ledger.csv`:

```csv
problem_id,chapter,kind,title,scope_ids,source_type,source_ref,answer_anchor,difficulty,minutes
```

Create `references/math-review.csv`:

```csv
problem_id,recomputed,conditions_checked,endpoints_checked,notation_checked,review_note
```

Create `references/page-budget.csv` with the 14 design rows totaling 102 pages and columns:

```csv
section,target_pages,final_start,final_end,actual_pages,status
```

- [ ] **Step 5: 验证来源门槛**

Run:

```powershell
Select-String -Path 'outputs/cmathc_nonmath_a_handbook/SOURCES.md' -Pattern '查询日期|https?://'
Import-Csv 'outputs/cmathc_nonmath_a_handbook/references/scope-matrix.csv' |
  Group-Object status | Select-Object Name,Count
```

Expected: 来源记录同时包含 URL 和查询日期；所有范围条目均为 `verified` 或 `gap`，且 `gap` 在 `SOURCE_GAPS.md` 中有对应说明。

- [ ] **Step 6: 追加任务检查点**

在根目录 `progress.md` 追加 Task 1 的来源、范围条目数量、未核实条目和验证命令结果。当前目录没有 Git 元数据，因此不执行提交命令。

---

### Task 2: 创建可测试的项目骨架和检查脚本

**Files:**
- Create: `outputs/cmathc_nonmath_a_handbook/requirements.txt`
- Create: `outputs/cmathc_nonmath_a_handbook/scripts/check_page_count.py`
- Create: `outputs/cmathc_nonmath_a_handbook/scripts/check_content.py`
- Create: `outputs/cmathc_nonmath_a_handbook/scripts/render_preview.py`
- Create: `outputs/cmathc_nonmath_a_handbook/tests/test_checks.py`
- Create: `outputs/cmathc_nonmath_a_handbook/build.ps1`

**Interfaces:**
- Consumes: `src/*.typ`、三个 CSV 台账和编译后的 PDF。
- Produces: `check_page_count(path, minimum, maximum) -> int`、`scan_project(root) -> dict[str, int]`、`validate_project(root) -> list[str]`、`render_pdf(pdf, out_dir, dpi) -> list[Path]`。

- [ ] **Step 1: 写检查器的失败测试**

`tests/test_checks.py` 覆盖四个行为：94 页 PDF 被拒绝、105 页 PDF 通过、缺少答案锚点被报告、精讲例题不是 50 道被报告。测试通过临时目录创建最小 CSV 和最小 PDF，不依赖正式章节。

Run:

```powershell
python -m pytest outputs/cmathc_nonmath_a_handbook/tests/test_checks.py -q
```

Expected: FAIL，原因是 `scripts.check_page_count` 和 `scripts.check_content` 尚不存在。

`requirements.txt` 固定写入：

```text
pypdf>=6.1,<7
PyMuPDF>=1.26,<2
pytest>=8.4,<9
```

- [ ] **Step 2: 实现页数检查器**

`check_page_count.py` 使用 `pypdf.PdfReader`，暴露：

```python
def check_page_count(path: Path, minimum: int = 95, maximum: int = 110) -> int:
    pages = len(PdfReader(str(path)).pages)
    if not minimum <= pages <= maximum:
        raise ValueError(f"page count {pages} is outside {minimum}..{maximum}")
    return pages
```

命令行接收 PDF 路径，成功打印 `PAGE_COUNT=<n>`，失败退出码为 1。

- [ ] **Step 3: 实现内容检查器**

`check_content.py` 读取 `problem-ledger.csv`、`scope-matrix.csv` 和 `math-review.csv`，按 `kind` 精确统计 `worked=50`、`quick=35`、`exercise=35`、`mock=12`；检查 `problem_id` 唯一、`answer_anchor` 非空、范围表无未解释 `gap`、50 个 worked ID 均在复核表、四个复核字段均为 `yes` 且 `review_note` 非空。命令行位置参数为项目根目录；`--allow-incomplete` 模式跳过最终四类题量的精确值检查，但仍检查已登记题目的 ID 唯一性、答案锚点、范围 ID 和已有 worked 复核行。

命令行成功打印：

```text
WORKED=50 QUICK=35 EXERCISE=35 MOCK=12 TOTAL=132
CONTENT_CHECK=PASS
```

失败时逐行打印具体问题并退出码为 1。

- [ ] **Step 4: 实现渲染器**

`render_preview.py` 使用 PyMuPDF 以 144 DPI 将每页保存为 `page-001.png` 形式，并按每行 4 页生成 `contact-sheet.png`。若输出目录已存在，只删除匹配 `page-*.png` 和 `contact-sheet.png` 的旧文件，不递归删除其他内容。

- [ ] **Step 5: 实现一键构建脚本**

`build.ps1` 顺序执行：检查 `typst` 和 `python`、创建 `output` 与 `logs/preview`、运行 `typst compile --root <project-root> src/main.typ output/全国大学生数学竞赛非数学A类备考手册.pdf`、运行页数检查、运行内容检查、全页渲染。任一步失败立即退出非零状态。

- [ ] **Step 6: 运行自动化测试**

Run:

```powershell
python -m pip install -r outputs/cmathc_nonmath_a_handbook/requirements.txt
python -m pytest outputs/cmathc_nonmath_a_handbook/tests/test_checks.py -q
```

Expected: 4 tests passed；不得出现跳过测试。

- [ ] **Step 7: 追加任务检查点**

在 `progress.md` 记录测试数量、命令和结果，并列出六个新增文件及回滚命令。

---

### Task 3: 建立 Typst 设计系统和可编译前置页

**Files:**
- Create: `outputs/cmathc_nonmath_a_handbook/src/settings.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/main.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/cover.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/chapter01.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/chapter02.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/chapter03.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/chapter04.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/chapter05.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/chapter06.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/chapter07.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/chapter08.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/chapter09.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/chapter10.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/chapter11.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/chapter12.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/answers.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/indexes.typ`
- Create: `outputs/cmathc_nonmath_a_handbook/src/references.typ`

**Interfaces:**
- Consumes: 范围映射表中已核实的动态事实。
- Produces: `worked-example`、`quick-example`、`exercise-set`、`method-card`、`warning-box`、`answer-entry` 六个 Typst 组件和全书排版规则。

- [ ] **Step 1: 用最小文档验证中文字体和书签能力**

Run a stdin probe or a temporary file under `work/` using A4 page, Chinese text, one heading and one formula. Compile with the intended local Typst executable.

Expected: 中文无方框，公式清晰，PDF 包含一级标题书签。记录实际采用的中文字体；优先使用 Windows 常见字体并提供回退列表。

- [ ] **Step 2: 编写 `settings.typ`**

设置 A4、页边距、10.5--11pt 正文、中文语言、两端对齐、章标题、页眉页脚和深蓝灰主题。六个组件必须接受显式 `id` 和标题参数；`worked-example` 还接受考点、难度、建议用时、来源属性和正文内容，组件输出可被 Typst 标签引用。

- [ ] **Step 3: 编写 `main.typ` 和 `cover.typ`**

`main.typ` 设置文档标题、作者标记为“备考手册编写项目”、PDF 元数据、可点击目录，并按固定顺序 include 全部章节、答案、索引和参考资料。本步骤同时创建所有章节文件，每个文件写入最终章标题和一段会保留在成书中的章节导读；后续内容任务在导读之后增加方法、例题与训练，不写临时施工文字。

`cover.typ` 写入封面、适用对象、使用方法、来源边界、符号约定和版本查询日期，不写未经官方来源确认的考试时间或分值。

- [ ] **Step 4: 编写 Chapter 1**

内容包括：竞赛定位、非数学 A 类范围映射说明、竞赛题与期末题/考研题区别、考场时间分配原则、证明题书写规范、12 周/8 周/4 周计划和不计入 132 题的诊断清单。所有动态信息附来源编号。

- [ ] **Step 5: 编译前置页**

Run:

```powershell
typst compile --root outputs/cmathc_nonmath_a_handbook `
  outputs/cmathc_nonmath_a_handbook/src/main.typ `
  work/handbook-frontmatter.pdf
```

Expected: 编译成功；封面、目录和 Chapter 1 无溢出；所有章节标题进入书签。

- [ ] **Step 6: 运行格式与渲染检查**

如果 `typstyle` 可用，对本任务创建的四个 `.typ` 文件逐个运行 `typstyle --check`；仅格式化本任务新建文件。将 `work/handbook-frontmatter.pdf` 渲染并检查封面、目录、页眉页脚和中文字体。

- [ ] **Step 7: 追加任务检查点**

在 `progress.md` 记录 Typst 版本、字体、编译命令和预览检查结论。

---

### Task 4: 编写 Chapter 2 函数、极限与连续

**Files:**
- Modify: `outputs/cmathc_nonmath_a_handbook/src/chapter02.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/src/answers.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/references/problem-ledger.csv`
- Modify: `outputs/cmathc_nonmath_a_handbook/references/math-review.csv`
- Modify: `outputs/cmathc_nonmath_a_handbook/references/scope-matrix.csv`

**Interfaces:**
- Consumes: Task 3 的语义组件和 Task 1 的范围 ID。
- Produces: `W02-01` 至 `W02-05`、`Q02-01` 至 `Q02-04`、`X02-01` 至 `X02-04`，共 13 题。

- [ ] **Step 1: 编写方法骨架**

覆盖等价无穷小的条件、Taylor 阶数判断、L'Hospital 边界、夹逼、单调有界、Stolz、根式有理化、对数化/指数化、递推数列、含积分极限、参数极限、左右极限、间断点、一致连续常用判定。每个方法给出识别信号和禁用条件。

- [ ] **Step 2: 编写 5 道精讲例题**

固定题型为：三角函数高阶消去极限、参数系数由有限极限反求、递推数列单调有界、Stolz 处理和式数列、连续性与零点个数。每题使用完整精讲结构并写明选择该方法的理由。

- [ ] **Step 3: 编写短例、训练和答案**

写入 4 道短例与 4 道训练，覆盖左右极限、根式有理化、含积分表达式极限和一致连续。`answers.typ` 中建立对应答案锚点；台账填写 13 个唯一编号。

- [ ] **Step 4: 独立复算和台账更新**

逐题检查展开阶数、L'Hospital 的未定式与可导区间、数列单调性起始下标、零点定理的连续区间。五道精讲题在 `math-review.csv` 的四个检查字段均填写 `yes` 并写具体复核结论。

- [ ] **Step 5: 编译和内容检查**

Run Typst compile and `python scripts/check_content.py --allow-incomplete`；该模式只验证当前已登记题目的编号、答案和复核记录，不要求最终总数。

Expected: 编译成功，Chapter 2 约 8 页，13 题均有答案定位，五道精讲题复核完整。

- [ ] **Step 6: 追加任务检查点**

在 `progress.md` 记录题量、页数、复算项目和编译结果。

---

### Task 5: 编写 Chapter 3 一元微分和 Chapter 4 一元积分

**Files:**
- Modify: `outputs/cmathc_nonmath_a_handbook/src/chapter03.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/src/chapter04.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/src/answers.typ`
- Modify: 三个题目与复核 CSV 台账。

**Interfaces:**
- Produces: Chapter 3 的 6 worked、4 quick、4 exercise；Chapter 4 的 7 worked、5 quick、5 exercise，共 31 题。

- [ ] **Step 1: 编写 Chapter 3 方法和 6 道精讲题**

方法覆盖高阶导数、Leibniz、隐函数/参数方程/反函数求导、Rolle/Lagrange/Cauchy/Taylor、辅助函数构造、单调性、极值、凹凸、渐近线、参数最值和函数不等式。精讲题固定为：Leibniz 高阶导数、构造辅助函数证明存在点、Rolle 链证明多个零点、导数法证明对数不等式、参数方程的根唯一性、Taylor 余项控制不等式。

- [ ] **Step 2: 完成 Chapter 3 的 4 道短例、4 道训练和答案**

短例与训练覆盖隐函数求导、参数曲线、渐近线、凹凸性、最值和证明题书写条件；更新编号、答案锚点和范围映射。

- [ ] **Step 3: 编写 Chapter 4 方法和 7 道精讲题**

方法覆盖换元、分部、有理函数、三角有理式、根式、区间变换、对称性、Wallis 型、参数积分、积分号下求导、积分中值定理、定积分不等式、广义积分判别和积分应用。精讲题固定为：部分分式积分、三角有理式积分、根式换元、对称区间变换、参数积分、含参数广义积分收敛、定积分不等式。

- [ ] **Step 4: 完成 Chapter 4 的 5 道短例、5 道训练和答案**

短例和训练覆盖分部积分递推、奇偶/周期性、面积体积、比较判别与 Abel/Dirichlet 思想。所有题登记来源属性，不确认出处的题标为经典模型或原创改编。

- [ ] **Step 5: 复算与编译验证**

Chapter 3 重点检查中值定理的闭区间连续和开区间可导；Chapter 4 重点检查换元后的区间、广义积分瑕点、参数取值和积分号下求导条件。编译后两章合计目标 19 页，31 题答案定位完整。

- [ ] **Step 6: 追加任务检查点**

在 `progress.md` 分别记录 Chapter 3 和 Chapter 4 的题量、复核结果与页数。

---

### Task 6: 编写 Chapter 5 空间解析几何与常微分方程、Chapter 6 多元微分

**Files:**
- Modify: `outputs/cmathc_nonmath_a_handbook/src/chapter05.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/src/chapter06.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/src/answers.typ`
- Modify: 三个题目与复核 CSV 台账。

**Interfaces:**
- Produces: Chapter 5 的 4 worked、3 quick、3 exercise；Chapter 6 的 4 worked、3 quick、3 exercise，共 20 题。

- [ ] **Step 1: 编写 Chapter 5 方法和 4 道精讲题**

范围覆盖向量运算、平面与直线、常见曲面、投影曲线；可分离、齐次、一阶线性、Bernoulli、全微分、可降阶、高阶常系数线性和 Euler 方程。精讲题固定为：平面直线综合位置关系、一阶线性方程、Bernoulli/恰当化方法选择、二阶常系数非齐次方程。

- [ ] **Step 2: 完成 Chapter 5 的短例、训练和答案**

3 道短例与 3 道训练覆盖投影曲线、可降阶方程、Euler 方程和简单应用。解答明确初始条件、通解/特解区别和可能丢失的奇解。

- [ ] **Step 3: 编写 Chapter 6 方法和 4 道精讲题**

范围覆盖二元极限、连续、偏导与可微、全微分、方向导数与梯度、复合/隐函数求导、多元 Taylor、无条件极值、Hessian、条件极值和 Lagrange 乘子。精讲题固定为：路径法与极限存在证明对照、可微性验证、隐函数二阶求导、多约束极值。

- [ ] **Step 4: 完成 Chapter 6 的短例、训练和答案**

3 道短例与 3 道训练覆盖方向导数、切平面、多元 Taylor 和参数极值；更新范围映射。

- [ ] **Step 5: 复算与编译验证**

Chapter 5 检查空间方向向量、方程解族和初值；Chapter 6 检查二元极限路径只能否定不能肯定、可微定义余项、Hessian 临界点条件和约束资格。两章合计目标 14 页。

- [ ] **Step 6: 追加任务检查点**

在 `progress.md` 记录 20 题台账、8 道精讲复算和范围覆盖结果。

---

### Task 7: 编写 Chapter 7 多元积分与场论、Chapter 8 无穷级数

**Files:**
- Modify: `outputs/cmathc_nonmath_a_handbook/src/chapter07.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/src/chapter08.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/src/answers.typ`
- Modify: 三个题目与复核 CSV 台账。

**Interfaces:**
- Produces: Chapter 7 的 6 worked、4 quick、4 exercise；Chapter 8 的 4 worked、3 quick、3 exercise，共 24 题。

- [ ] **Step 1: 编写 Chapter 7 方法和 6 道精讲题**

范围覆盖二重/三重积分、换序、极/柱/球坐标、一般变量替换、两类曲线积分、路径无关、Green、两类曲面积分、Gauss、Stokes、散度旋度和几何物理应用。精讲题固定为：交换积分次序、极坐标分区、球坐标三重积分、Green 公式与补线、路径无关求原函数、Gauss/Stokes 的方向判断。

- [ ] **Step 2: 完成 Chapter 7 的短例、训练和答案**

4 道短例与 4 道训练覆盖 Jacobian、质心/平均值、第一类曲面积分和第二类曲面积分。每题明确区域、坐标范围、方向和 Jacobian。

- [ ] **Step 3: 编写 Chapter 8 方法和 4 道精讲题**

范围覆盖正项级数判别、交错级数、绝对/条件收敛、幂级数半径和端点、逐项求导积分、函数展开和求和、Fourier 系数、Dirichlet 定理、正弦/余弦展开。精讲题固定为：含参数正项级数、绝对与条件收敛分类、幂级数端点和求和、分段函数 Fourier 展开与端点值。

- [ ] **Step 4: 完成 Chapter 8 的短例、训练和答案**

3 道短例与 3 道训练覆盖比值/根值、积分判别、幂级数微分积分和半区间展开。端点逐个讨论，不以开区间结论替代。

- [ ] **Step 5: 复算与编译验证**

重点检查坐标区域、方向、Jacobian、级数判别前提、幂级数端点和 Fourier 间断点取半和。两章合计目标 17 页。

- [ ] **Step 6: 追加任务检查点**

在 `progress.md` 记录 24 题、10 道精讲复算和页数结果。

---

### Task 8: 编写 Chapter 9 线性代数

**Files:**
- Modify: `outputs/cmathc_nonmath_a_handbook/src/chapter09.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/src/answers.typ`
- Modify: 三个题目与复核 CSV 台账。

**Interfaces:**
- Produces: 8 worked、5 quick、5 exercise，共 18 题。

- [ ] **Step 1: 编写完整方法框架**

覆盖行列式展开与 Vandermonde、矩阵运算/逆/秩/分块、向量组相关性与极大无关组、基和坐标、内积与正交化、齐次/非齐次方程组、特征值与对角化、实对称矩阵、二次型、惯性定理和正定判别。

- [ ] **Step 2: 编写 8 道精讲题**

固定题型为：递推/结构行列式、分块矩阵求逆、参数矩阵秩、向量组与基变换、含参数线性方程组、特征值与对角化、正交变换化二次型、正定矩阵判别。每题标明采用初等变换、结构观察或谱方法的选择依据。

- [ ] **Step 3: 编写 5 道短例、5 道训练和答案**

覆盖伴随矩阵、Schmidt 正交化、基础解系、相似不变量和合同/相似区别。矩阵答案保留关键行变换，不使用“计算可得”跳过秩变化。

- [ ] **Step 4: 独立复算**

检查行列式符号、初等变换影响、参数分支、特征子空间维数、可对角化条件、正交矩阵方向和二次型惯性指数。八道精讲题全部登记复核。

- [ ] **Step 5: 编译和范围检查**

Expected: Chapter 9 约 11 页，18 题均有答案锚点，线性代数范围条目全部至少映射到一个内容 ID。

- [ ] **Step 6: 追加任务检查点**

在 `progress.md` 记录线性代数范围条目、题量、页数和复核结果。

---

### Task 9: 编写 Chapter 10 综合构造和 Chapter 11 高频速查

**Files:**
- Modify: `outputs/cmathc_nonmath_a_handbook/src/chapter10.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/src/chapter11.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/src/answers.typ`
- Modify: 三个题目与复核 CSV 台账。

**Interfaces:**
- Produces: Chapter 10 的 4 worked、2 quick、2 exercise；Chapter 11 的 2 worked、2 quick、2 exercise，共 14 题。

- [ ] **Step 1: 编写 Chapter 10**

方法覆盖辅助函数、零点定理、单调唯一性、中值定理链、Taylor 余项、积分辅助函数、参数法、反证法、缩放法和局部到整体。四道精讲题固定为：辅助函数证明存在性、连续使用中值定理、积分定义辅助函数、微分与积分综合证明。

- [ ] **Step 2: 编写 Chapter 10 短例、训练和答案**

2 道短例和 2 道训练用于区分“先猜辅助函数”与“由目标式反推导数”，解答写出构造来源而非只给最终函数。

- [ ] **Step 3: 编写 Chapter 11 高频速查**

写入 40--50 个触发信号、50 个易错点、Taylor 与等价无穷小表、积分公式、级数判别流程、线性代数判断表、证明题句式和考场检查清单。两道精讲题展示跨方法快速选择；2 道短例和 2 道训练验证速查表可直接使用。

- [ ] **Step 4: 复算、去重和编译**

检查 Chapter 11 不大段重复前文，只使用页码/标签跳转；14 题答案完整。两章合计目标 10 页。

- [ ] **Step 5: 追加任务检查点**

在 `progress.md` 记录触发信号数、易错点数、14 题台账和去重检查结论。

---

### Task 10: 编写两套模拟题、完整答案和索引

**Files:**
- Modify: `outputs/cmathc_nonmath_a_handbook/src/chapter12.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/src/answers.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/src/indexes.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/src/references.typ`
- Modify: `outputs/cmathc_nonmath_a_handbook/references/problem-ledger.csv`
- Modify: `outputs/cmathc_nonmath_a_handbook/references/scope-matrix.csv`

**Interfaces:**
- Produces: `M01-01` 至 `M01-06`、`M02-01` 至 `M02-06`；完整答案系统、题目索引和技巧索引。

- [ ] **Step 1: 编写模拟题一**

六题依次覆盖极限/微分、积分、微分方程或空间几何、多元积分或场论、级数、线性代数；难度递增，使用原创或经典模型重组，给出建议总用时和分题评分点。

- [ ] **Step 2: 编写模拟题二**

保持六大范围板块平衡，但不复用模拟题一的核心变形；给出建议总用时和评分点。两套均不得使用“官方模拟题”或“历届原题”表述，除非存在可核实授权来源。

- [ ] **Step 3: 完成答案系统**

第一套给完整解答，第二套给关键步骤和评分点。补齐全部 quick、exercise 和 worked 的答案定位；运行脚本确认 132 个 `answer_anchor` 均非空且 Typst 标签可解析。

- [ ] **Step 4: 生成题目索引和技巧索引**

题目索引按章节和方法双重组织，列出题号、题型、难度和页码；技巧索引按“极限、证明、积分、坐标、级数、线性代数”分类。索引使用 Typst 引用自动显示页码，避免手写页码失效。

- [ ] **Step 5: 编写参考资料页**

`references.typ` 仅列出实际使用的来源，动态信息标注查询日期；附件指南记录书名、主编、命题组、出版社、年份和 ISBN。网络来源显示可读标题和 URL，不显示内部工具引用标记。

- [ ] **Step 6: 编译和链接检查**

Expected: 目录、题目索引、技巧索引和答案引用可点击；模拟与答案部分约 10 页，参考与索引约 4 页。

- [ ] **Step 7: 追加任务检查点**

在 `progress.md` 记录两套模拟题结构、答案覆盖率和索引链接检查结果。

---

### Task 11: 完成 README、构建说明和全量机器验收

**Files:**
- Create: `outputs/cmathc_nonmath_a_handbook/README.md`
- Create: `outputs/cmathc_nonmath_a_handbook/PROJECT_PLAN.md`
- Modify: `outputs/cmathc_nonmath_a_handbook/build.ps1`
- Create: `outputs/cmathc_nonmath_a_handbook/logs/QUALITY_REPORT.md`

**Interfaces:**
- Consumes: 全部 Typst 源、台账和检查脚本。
- Produces: 可复现构建说明、主 PDF 和机器验收报告。

- [ ] **Step 1: 编写 README**

说明 Typst 和 Python 版本、`python -m pip install -r requirements.txt`、`powershell -ExecutionPolicy Bypass -File build.ps1`、产物路径、项目目录、来源边界和常见字体问题。命令必须从项目根目录可直接复制执行。

- [ ] **Step 2: 编写项目验收矩阵**

`PROJECT_PLAN.md` 列出 14 个页数预算、50/35/35/12 题量、九大官方范围板块、交付物和每项对应的验证命令或人工检查位置。

- [ ] **Step 3: 运行全量构建**

Run:

```powershell
Set-Location 'outputs/cmathc_nonmath_a_handbook'
python -m pytest tests/test_checks.py -q
powershell -ExecutionPolicy Bypass -File .\build.ps1
```

Expected: 测试全部通过；Typst 编译成功；内容检查输出 `WORKED=50 QUICK=35 EXERCISE=35 MOCK=12 TOTAL=132`；页数在 95--110。

- [ ] **Step 4: 执行占位与乱码扫描**

扫描所有 `.typ`、`.md` 和 CSV，拒绝匹配 `T(?:BD|ODO)` 的待补内容标记、替换字符 `�`、常见乱码特征串和空答案锚点。正文不得保留任何仅用于施工说明、而不服务读者的句子。

- [ ] **Step 5: 填写机器验收报告**

`QUALITY_REPORT.md` 记录 Typst/Python 版本、构建命令、测试数量、页数、四类题量、范围条目数、答案覆盖率、精讲复核数和 PDF 文本提取结果。每项附实际数值，不使用笼统的“正常”。

- [ ] **Step 6: 追加任务检查点**

在 `progress.md` 记录全量构建结果、产物路径和机器验收数值。

---

### Task 12: 全页视觉复核、页数调优和最终交付

**Files:**
- Modify: `outputs/cmathc_nonmath_a_handbook/src/*.typ` only where a verified layout or mathematical defect exists
- Modify: `outputs/cmathc_nonmath_a_handbook/references/page-budget.csv`
- Modify: `outputs/cmathc_nonmath_a_handbook/logs/QUALITY_REPORT.md`
- Produce: `outputs/cmathc_nonmath_a_handbook/output/全国大学生数学竞赛非数学A类备考手册.pdf`

**Interfaces:**
- Consumes: Task 11 的主 PDF 和 `logs/preview/page-*.png`。
- Produces: 通过最终验收的稳定 PDF 与完整质量报告。

- [ ] **Step 1: 检查全页联系表**

检查页序、空白页、章首页、密度突变、孤立标题和明显越界。将问题按 `页码 | 类型 | 处理文件 | 修复动作` 写入质量报告；没有问题的页段也按章节记录为已检查。

- [ ] **Step 2: 抽查原始分辨率页面**

逐页打开含长公式、矩阵、分段函数、表格、模拟题、答案和索引的页面，确认无公式截断、表格溢出、字体替换、边框重叠和低清晰度。

- [ ] **Step 3: 调整至目标页数**

若少于 95 页，增加已有精讲题的关键步骤解释、方法比较或必要图示；若超过 110 页，压缩重复方法说明、合并低价值空白和缩短非核心例题说明。禁止删除官方范围覆盖、降低 50 道精讲或 132 道总题量。每轮修改后重新编译和全页渲染。

- [ ] **Step 4: 执行最终数学抽检**

对 50 道精讲题逐条核对 `math-review.csv`，再抽查全部 12 道模拟题和每章至少 2 道短例/训练。发现错误时修正文题、答案、索引和台账四处的一致性。

- [ ] **Step 5: 验证 PDF 文本和导航**

使用 pypdf 提取中文标题、任意三处公式附近文本和全部书签；点击目录、题目索引、技巧索引及答案回链。Expected: 中文可复制，书签层级正确，内部链接落点正确。

- [ ] **Step 6: 运行最终不可变验收命令**

Run:

```powershell
Set-Location 'outputs/cmathc_nonmath_a_handbook'
python -m pytest tests/test_checks.py -q
python scripts/check_content.py .
python scripts/check_page_count.py 'output/全国大学生数学竞赛非数学A类备考手册.pdf'
python scripts/render_preview.py 'output/全国大学生数学竞赛非数学A类备考手册.pdf' 'logs/preview' --dpi 144
```

Expected: 全部命令退出码 0；题量为 50/35/35/12；总题量 132；页数 95--110；最终渲染图片数量等于 PDF 页数。

- [ ] **Step 7: 完成质量报告和最终日志**

在 `QUALITY_REPORT.md` 写入最终页数、PDF SHA-256、文件大小、题量、范围映射、数学复核、视觉复核和构建结果。在根目录 `progress.md` 追加最终交付记录、全部交付文件清单、验证证据和可执行回滚方式。

---

## Final Acceptance Checklist

- [ ] 最新官方非数学专业 A 类范围有可追溯来源和查询日期。
- [ ] `scope-matrix.csv` 中每个 verified 范围条目至少映射一个正文内容 ID。
- [ ] 主 PDF 页数为 95--110，目标 104--108。
- [ ] worked=50、quick=35、exercise=35、mock=12、total=132。
- [ ] 132 道题答案锚点完整，50 道精讲复核记录完整。
- [ ] 两套模拟题各 6 题，第一套完整解答，第二套关键步骤与评分点。
- [ ] 目录、书签、题目索引、技巧索引和答案跳转可用。
- [ ] 全页渲染无空白、越界、截断、乱码、孤立标题或表格溢出。
- [ ] `build.ps1` 在 Windows 从项目根目录一条命令生成主 PDF。
- [ ] README、来源清单、信息缺口、质量报告和可编辑源文件齐全。
