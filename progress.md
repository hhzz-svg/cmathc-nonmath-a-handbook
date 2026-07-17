## 2026-07-17 - Task: 固化非数学 A 类备考手册设计

### What was done

- 根据用户确认的“完整覆盖范围、精讲例题约 50 道”要求，确定 95--110 页内的内容结构、页数预算、题量分配、来源流程、Typst 项目结构和验收标准。
- 明确附件中的 2022 年参赛指南仅作为基础参考，动态范围和规则须以制作时核实的最新官方信息为准。

### Testing

- 人工核对各部分页数预算合计为 102 页，符合后续排版至 104--108 页且不超过 110 页的设计目标。
- 人工核对精讲例题分配合计为 50 道；设计总题量为约 132 道，高于 120 道验收下限。
- 扫描设计说明，未发现 `TBD`、`TODO` 或未填写占位段落。

### Notes

- `docs/superpowers/specs/2026-07-17-cmathc-nonmath-a-handbook-design.md`：新增经用户确认方向整理的完整设计说明。
- `progress.md`：追加本轮设计固化和验证记录。
- 回滚方式：执行 `Remove-Item -LiteralPath 'docs\superpowers\specs\2026-07-17-cmathc-nonmath-a-handbook-design.md'` 删除本轮正式设计文档；`progress.md` 作为历史记录保留。

## 2026-07-17 - Task: 编制非数学 A 类备考手册实施计划

### What was done

- 将已确认设计拆解为 12 个可独立验证的实施任务，覆盖官方范围核验、项目骨架、12 章内容、50 道精讲复算、132 道题答案、索引、全量构建和最终视觉验收。
- 锁定正式交付目录、文件职责、章节题量、检查脚本接口、构建命令和各阶段成功标准。

### Testing

- 计划结构检查通过：共 12 个连续任务、85 个可勾选步骤，包含规定的 agentic workers 头部。
- 设计覆盖扫描通过：页数、50 道精讲、132 道总题量、范围映射、来源缺口、Typst、构建脚本、题目/技巧索引及全页渲染均有对应实施任务。
- 占位内容扫描通过：未发现未完成标记、模糊的后续实现指令或跨任务省略引用。

### Notes

- `docs/superpowers/plans/2026-07-17-cmathc-nonmath-a-handbook.md`：新增完整实施计划，明确 12 个任务的文件、接口、步骤和验证命令。
- `progress.md`：追加本轮计划编制与自检记录。
- 当前工作区不是 Git 仓库，因此未执行提交；未自行初始化仓库。
- 回滚方式：执行 `Remove-Item -LiteralPath 'docs\superpowers\plans\2026-07-17-cmathc-nonmath-a-handbook.md'` 删除本轮实施计划；`progress.md` 作为历史记录保留。

## 2026-07-17 - Task: 初始化私有 GitHub 项目

### What was done

- 根据用户授权，为备考手册建立 Git 版本管理所需的忽略规则和仓库入口说明。
- 预留 `.worktrees/` 作为隔离工作树目录，确保多代理任务不会直接在主分支并行施工。

### Testing

- GitHub CLI 版本为 2.95.0，账户 `hhzz-svg` 已认证，令牌具有创建私有仓库所需的 `repo` 权限。
- 仓库名 `hhzz-svg/cmathc-nonmath-a-handbook` 查询结果为空，可用于新建私有仓库。

### Notes

- `.gitignore`：新增中间目录、隔离工作树和 Python 缓存忽略规则。
- `README.md`：新增仓库目标、设计、计划、交付目录和进度入口。
- `progress.md`：追加私有仓库初始化准备记录。
- 回滚方式：在首次提交前可删除 `.gitignore` 与根目录 `README.md`；仓库创建后可在 GitHub 仓库设置中删除远程仓库，本地可删除 `.git` 元数据回到未版本化状态。

## 2026-07-17 - Task: 建立多代理隔离施工环境

### What was done

- 创建 `codex/write-handbook` 隔离工作树分支，后续实现不直接修改 `main`。
- 将多代理任务简报、报告和持久进度台账目录加入 Git 忽略范围。

### Testing

- `git worktree` 已创建，隔离工作树当前分支为 `codex/write-handbook`，基线提交为 `14e09e7`。
- 基线仓库尚无可执行项目代码，因此无自动化测试入口；版本状态检查正常。

### Notes

- `.gitignore`：新增 `.superpowers/` 忽略规则。
- `progress.md`：追加隔离施工环境记录。
- 回滚方式：在主工作区执行 `git worktree remove '.worktrees/write-handbook'`，再删除分支 `git branch -D 'codex/write-handbook'`。

## 2026-07-17 - Task: 核验最新官方范围并建立来源台账

### What was done

- 核验中国数学会 2026 年发布的第十八届竞赛通知，确认非数学专业 A 类为理工类、初赛只考高等数学，线性代数仅属于决赛内容。
- 以第十八届通知确定当前科目边界，以竞赛命题组 2022 年正式出版指南补充八大高等数学逐项细目，建立 92 条范围记录。
- 建立来源、信息缺口、题目、数学复核和页数预算台账，并明确原设计中 11 页线性代数章节与初赛定位冲突。

### Testing

- 官方来源门槛通过：记录 4 个中国数学会第一方页面或附件，所有动态事实均含 URL 与查询日期。
- 范围表检查通过：92 个唯一 ID，其中 `verified=91`、`gap=1`；唯一缺口 `S-HM-GAP-001` 已在 `SOURCE_GAPS.md` 说明且未绑定正文。
- 字段检查通过：`coverage_kind` 仅使用 `reference`，`status` 仅使用 `verified` 或 `gap`，核验日期统一为 2026-07-17。
- 页数预算检查通过：14 行合计 102 页；线性代数行标记为 `scope-conflict`，等待计划修订。
- 附件指南已成功提取到 `work/nonmath_scope_2022.txt`，可检出“非数学专业类”“高等数学”和“线性代数”。

### Notes

- `outputs/cmathc_nonmath_a_handbook/SOURCES.md`：新增第一方动态来源、权威出版物和当前范围结论。
- `outputs/cmathc_nonmath_a_handbook/SOURCE_GAPS.md`：新增逐项大纲缺口、试卷结构缺口和线性代数计划冲突。
- `outputs/cmathc_nonmath_a_handbook/references/scope-matrix.csv`：新增 92 条官方范围与范围边界映射。
- `outputs/cmathc_nonmath_a_handbook/references/problem-ledger.csv`：新增题目台账表头。
- `outputs/cmathc_nonmath_a_handbook/references/math-review.csv`：新增精讲例题复核台账表头。
- `outputs/cmathc_nonmath_a_handbook/references/page-budget.csv`：新增 14 行、102 页的设计预算并标记范围冲突。
- `progress.md`：追加本轮来源核验、范围结论和验证证据。
- 回滚点：提交前基线为 `7129f7c`；可执行 `git restore --source=7129f7c -- progress.md` 并删除 `outputs/cmathc_nonmath_a_handbook/`，撤销本任务文件改动。

## 2026-07-17 - Task: 修正当前官方范围矩阵的线性代数边界

### What was done

- 根据独立审查结论，从当前范围矩阵删除 2022 年指南中的 27 条线性代数历史细目，只保留第十八届通知可直接证明的 `S-LA-000` 科目边界。
- 清除 `S-LA-000` 的章节和正文 ID 绑定，避免后续检查把决赛科目边界误判为初赛正文要求。

### Testing

- 修正后范围表共有 65 个唯一 ID，其中 `verified=64`、`gap=1`；不存在 `S-LA-101` 至 `S-LA-603`。
- `S-LA-000` 的 `chapter` 与 `content_id` 均为空；唯一缺口 `S-HM-GAP-001` 仍与 `SOURCE_GAPS.md` 同步。
- 页数预算保持 14 行、合计 102 页，本轮未扩展到章节计划重写。

### Notes

- `outputs/cmathc_nonmath_a_handbook/references/scope-matrix.csv`：删除未经第十八届通知逐项确认的线性代数历史细目。
- `outputs/cmathc_nonmath_a_handbook/SOURCES.md`：明确线性代数历史细目不进入当前官方范围矩阵。
- `outputs/cmathc_nonmath_a_handbook/SOURCE_GAPS.md`：明确仅保留不绑定正文的 `S-LA-000` 边界。
- `progress.md`：以追加方式记录原 92/91 统计已由本轮 65/64 统计取代，不改写历史日志。
- 回滚点：修复前提交为 `118d8ee`；可执行 `git restore --source=118d8ee -- outputs/cmathc_nonmath_a_handbook/SOURCES.md outputs/cmathc_nonmath_a_handbook/SOURCE_GAPS.md outputs/cmathc_nonmath_a_handbook/references/scope-matrix.csv progress.md` 撤销本轮修复。

## 2026-07-17 - Task: 创建可测试的构建与质量检查基础设施

### What was done

- 新增 PDF 页数检查、内容台账检查和全页预览渲染脚本，并提供可直接调用的 Python 接口和命令行入口。
- 新增 Windows 一键构建脚本，按 Typst 编译、页数检查、内容检查和全页渲染的顺序执行，任一步失败立即停止。
- 建立四个行为测试，覆盖页数上下限、答案锚点缺失和精讲题数量不符。

### Testing

- RED：首次运行 `python -m pytest outputs/cmathc_nonmath_a_handbook/tests/test_checks.py -q`，因 `scripts.check_content` 尚不存在而在测试收集阶段失败，符合预期。
- GREEN：安装 `requirements.txt` 后再次运行同一命令，结果为 `4 passed in 0.18s`，无跳过测试。
- 实际台账运行 `check_content.py --allow-incomplete`，输出 `CONTENT_CHECK=PASS`；当前题量为零，未提前要求最终 50/35/35/12 数量。
- 两页测试 PDF 的页数 CLI 输出 `PAGE_COUNT=2`；渲染输出 2 张页面 PNG 和联系表，旧 `page-999.png` 被清理，非预览文件 `keep.txt` 被保留。
- 三个 Python 脚本通过 `py_compile`，`build.ps1` 通过 PowerShell ScriptBlock 语法解析，`git diff --check` 通过。

### Notes

- `outputs/cmathc_nonmath_a_handbook/requirements.txt`：新增 pypdf、PyMuPDF 和 pytest 版本范围。
- `outputs/cmathc_nonmath_a_handbook/scripts/check_page_count.py`：新增 95--110 页默认区间检查和 CLI。
- `outputs/cmathc_nonmath_a_handbook/scripts/check_content.py`：新增题量、编号、答案、范围缺口和精讲复核台账检查。
- `outputs/cmathc_nonmath_a_handbook/scripts/render_preview.py`：新增逐页 PNG 与四列联系表渲染。
- `outputs/cmathc_nonmath_a_handbook/tests/test_checks.py`：新增四个基础设施行为测试。
- `outputs/cmathc_nonmath_a_handbook/build.ps1`：新增 Windows 一键构建与验收入口。
- `progress.md`：追加本轮实现和测试记录。
- 回滚点：本任务基线为 `977a85a`；可执行 `git restore --source=977a85a -- progress.md` 并删除上述六个新增文件，撤销本任务改动。

## 2026-07-17 - Task: 修正 partial 范围校验与 PDF 资源释放

### What was done

- 根据独立审查补充 unresolved gap 绑定检查，题目引用 `status=gap` 的范围条目时始终报错，`--allow-incomplete` 不放行。
- 为 partial 模式补充 gap 绑定、重复题号、未知范围和精讲题缺少复核记录的回归测试。
- 将主 PDF 与联系表临时 PDF 改为上下文管理，确保渲染或联系表生成异常时仍释放文件句柄。

### Testing

- RED：新增 gap 绑定测试后运行 `python -m pytest outputs/cmathc_nonmath_a_handbook/tests/test_checks.py -q`，结果为 `1 failed, 7 passed`；失败项确认现有实现未拒绝 `S-HM-GAP-001`。
- GREEN：实现 gap 拒绝分支后运行同一命令，结果为 `8 passed in 0.23s`。
- 页数 smoke 的准确命令为 `python outputs/cmathc_nonmath_a_handbook/scripts/check_page_count.py work/task2-review-two-pages.pdf --minimum 2 --maximum 2`，输出 `PAGE_COUNT=2`；该结果不代表默认 95--110 页检查接受两页 PDF。
- 实际台账运行 `check_content.py --allow-incomplete`，输出 `CONTENT_CHECK=PASS`。
- 两页 PDF 渲染输出 2 张页面 PNG 和联系表；旧 `page-999.png` 被清理，`keep.txt` 被保留。
- 三个 Python 脚本通过 `py_compile`，`git diff --check` 通过。

### Notes

- `outputs/cmathc_nonmath_a_handbook/scripts/check_content.py`：新增题目绑定 unresolved gap 的拒绝逻辑。
- `outputs/cmathc_nonmath_a_handbook/scripts/render_preview.py`：为 PyMuPDF 文档增加异常安全的上下文管理。
- `outputs/cmathc_nonmath_a_handbook/tests/test_checks.py`：新增四条 partial 模式回归路径。
- `progress.md`：仅追加本轮更正和准确的两页 PDF smoke 命令，不改写旧记录。
- 回滚点：修复前提交为 `71a2078`；可执行 `git restore --source=71a2078 -- outputs/cmathc_nonmath_a_handbook/scripts/check_content.py outputs/cmathc_nonmath_a_handbook/scripts/render_preview.py outputs/cmathc_nonmath_a_handbook/tests/test_checks.py progress.md` 撤销本轮修复。
