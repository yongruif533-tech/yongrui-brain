# 接入指南：让每台电脑、每个 AI 共用一颗大脑

> 仓库：https://github.com/yongruif533-tech/yongrui-brain
> 原则：**Git 仓库是唯一事实源**；每个 AI 只负责"读取入口"和"写回记忆"。

## 0. 接入前先理解

```
首次：git clone  →  日常：读 AGENTS.md  →  工作  →  写回 memory/  →  commit + push  →  其他端 pull
```

- 任何 AI 都可以是"前端"，仓库是"后端的大脑"。
- 换电脑、换模型都不需要重新解释你是谁。
- 所有更新都有 Git 历史，可回滚、可审计。

---

## 1. 本机 AI 编程工具

| 工具 | 入口文件 | 做法 |
|---|---|---|
| **ZCode** | `AGENTS.md` | 在仓库目录打开，自动读取 |
| **Cursor** | `AGENTS.md` + `.cursor/rules/brain.mdc` | 用 Cursor 打开仓库根目录 |
| **Codex / OpenAI 系编码工具** | `AGENTS.md` | 在仓库目录中启动 |
| **Claude Code** | `CLAUDE.md` | 在仓库目录中启动；`CLAUDE.md` 已指向 `AGENTS.md` |
| **Trae / 其他** | 自定义规则或 `AGENTS.md` | 把 `AGENTS.md` 设为项目规则，或在对话开头粘贴 `prompts/context-pack.md` |

第一次使用：

```bash
git clone https://github.com/yongruif533-tech/yongrui-brain.git
cd yongrui-brain
```

> 建议把仓库放在固定路径（如 `~/yongrui-brain`），让所有工具都从这里打开。

---

## 2. 网页版 AI

### 方式 A：轻量（任何对话）

把 [`prompts/context-pack.md`](../prompts/context-pack.md) 全文粘贴到对话开头。
适合 ChatGPT、Claude、Gemini、Kimi、豆包、DeepSeek 等。

### 方式 B：长期（推荐）

新建一个专属空间，把档案作为知识库：

| 平台 | 空间 | 加入内容 |
|---|---|---|
| ChatGPT | Projects | `AGENTS.md`、`profile/*.md` |
| Claude | Projects | 同上 |
| Gemini | Gems | 把 `context-pack.md` 写入指令，必要时附档案 |
| Kimi / 豆包 / 其他 | 智能体 / 知识库 | 同上 |
| Notion AI | 页面 | 把 `AGENTS.md` 作为页面内容 |

### 方式 C：给能联网的 AI 一个链接

```text
请先读取 https://raw.githubusercontent.com/yongruif533-tech/yongrui-brain/main/AGENTS.md
以及与任务相关的 profile 文件，然后开始工作。
```

> 只有公开仓库能这样用；私有仓库需要 Token，不建议把 Token 贴进对话。

---

## 3. API / 自建应用

```python
import urllib.request

BASE = "https://raw.githubusercontent.com/yongruif533-tech/yongrui-brain/main/"
brain = urllib.request.urlopen(BASE + "AGENTS.md").read().decode("utf-8")
system_prompt = "以下是用户档案，请作为背景事实：\n\n" + brain
```

建议缓存并按 commit 更新，避免每次请求都拉取。

---

## 4. 新电脑接入

```bash
git clone https://github.com/yongruif533-tech/yongrui-brain.git
```

首次 push 需要登录一次 GitHub（Git Credential Manager 会记住）。

### 可选：定时自动同步

**Windows（计划任务）**：

```powershell
schtasks /Create /TN "YongruiBrainSync" /SC HOURLY /TR "powershell -NoProfile -ExecutionPolicy Bypass -File C:\Users\<你的用户名>\yongrui-brain\scripts\sync.ps1" /F
```

**macOS / Linux（cron，每天 9:00 与 21:00）**：

```bash
crontab -e
# 添加：
0 9,21 * * * cd ~/yongrui-brain && ./scripts/sync.sh >> ~/yongrui-brain-sync.log 2>&1
```

脚本逻辑：`git pull --rebase` → 若有本地变更则提交并推送。冲突时按 Git 提示手动解决。

---

## 5. 日常写回流程

每次重要工作结束（无论用哪个 AI）：

1. 让 AI 按 `memory/README.md` 的格式更新：
   - 项目进展 → `memory/projects/<slug>.md`
   - 当日要点 → `memory/journal/YYYY-MM.md`
   - 稳定新事实 → `profile/*.md`
2. 检查是否包含隐私信息（手机号、邮箱、身份证号、患者数据）。
3. 提交：

```bash
git add -A
git commit -m "memory: <一句话>"
git push
```

提交信息示例：

- `memory: 专利交底书定稿`
- `memory: 补充软著登记号`
- `profile: 更新技能矩阵`

---

## 6. 隐私与可见性

| 方案 | 适用 | 取舍 |
|---|---|---|
| **公开仓库（当前）** | 让网页版 AI 直接读取 | 必须脱敏；联系方式不提交 |
| **私有仓库** | 只在本机 / 本地工具使用 | 网页版 AI 无法读链接；改用 Project 上传 |
| **私有 + 单独公开摘要** | 既要隐私又要跨 AI | 维护两份，成本高 |

当前仓库已脱敏：无手机号、邮箱、身份证号、住址门牌、患者数据。
本地敏感信息放 `private/`（已在 `.gitignore` 排除），或另建私有仓库保存。

**如果误提交了隐私**：

```bash
# 立即从工作区移除并从仓库删除（历史仍存在）
git rm --cached private/contact.md
git commit -m "chore: remove private file"
git push
```

若已进入历史，应使用 `git filter-repo` 重写历史并强制推送，必要时作废相关 Token。

---

## 7. FAQ

**Q：两台电脑同时改了同一个文件怎么办？**
A：`git pull --rebase`，按冲突提示合并；档案类文件冲突通常保留两边内容、更新日期。

**Q：AI 写回时覆盖了旧日志？**
A：日志是追加制；若被覆盖，用 `git log -p memory/journal/` 找回并恢复。

**Q：想整体回滚到某个版本？**
A：`git log` 找到 commit，`git revert <sha>` 生成反向提交（不要用 `reset --hard` 强推，会丢失其他设备的提交）。

**Q：网页版 AI 读不到最新内容？**
A：raw 链接有 CDN 缓存，通常几分钟内更新；可加 `?t=<时间戳>` 绕过。

**Q：要不要把所有对话都存进来？**
A：不要。只存**结论、决策、进展、稳定事实**；原始对话留在各平台，避免仓库膨胀与隐私风险。
