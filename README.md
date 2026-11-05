# 🧠 Yongrui Brain

> 冯勇瑞的 AI 个人档案与共享大脑
> 一个仓库，所有电脑、所有 AI，共享同一份"关于我"的上下文。

**仓库地址**：https://github.com/yongruif533-tech/yongrui-brain

---

## 为什么需要它

每换一个 AI、换一台电脑，你都要重新解释：我是谁、我在做什么、我习惯怎么合作。
ChatGPT 的记忆只属于 ChatGPT，Cursor 的规则只属于那台电脑，换一个工具就等于失忆。

这个仓库把这些上下文从**平台**里拿出来，放进**你自己的 Git 仓库**：

- **跨电脑**：`git clone` 一次，之后 `git pull` 同步
- **跨 AI**：每个 AI 通过各自的入口文件（`AGENTS.md` / `CLAUDE.md` / 系统提示）读取同一份事实
- **可版本化**：记忆会累积、可回溯、可修复，不会因为某个平台的"记忆上限"被清空
- **可迁移**：任何支持文件读取的 AI 都能接入，不绑定任何厂商

## 终极方案：一颗大脑，三层结构

```
                         ┌───────────────────────────────┐
                         │        GitHub Repository      │
                         │  yongruif533-tech/yongrui-brain│
                         │   唯一事实源（Single Source    │
                         │        of Truth）             │
                         └───────────────┬───────────────┘
                 ┌───────────────┬───────┴───────┬───────────────┐
                 ▼               ▼               ▼               ▼
            电脑 A            电脑 B         本地 AI 编程工具     网页版 AI
          git pull          git pull      ZCode / Cursor /     ChatGPT / Claude /
                                            Codex / Claude      Gemini / Kimi /
                                              Code             豆包
                                          (AGENTS.md)      (context-pack / Project)
```

| 层 | 目录 | 回答什么问题 | 变更频率 |
|---|---|---|---|
| **事实层** | `profile/` | 我是谁？教育、科研、技能、成果、目标 | 低 |
| **记忆层** | `memory/` | 我正在做什么？做过什么决定？ | 高 |
| **接口层** | `AGENTS.md`、`CLAUDE.md`、`prompts/`、`.cursor/` | 每个 AI 从哪里开始读？ | 低 |

**同步回路**：任何一端读取 → 工作 → 把新事实写回 `memory/` → `git push` → 其他端 `git pull`。
Git 的 commit 就是这颗大脑的突触；记忆用文件版本化，不依赖任何单一平台的"记忆功能"。

## 5 分钟接入

### 1. 本机 AI 编程工具（ZCode / Cursor / Codex / Claude Code）

```bash
git clone https://github.com/yongruif533-tech/yongrui-brain.git
```

- **ZCode / Cursor / Codex**：自动读取仓库根目录的 `AGENTS.md`
- **Claude Code**：自动读取 `CLAUDE.md`（已放好，指向 `AGENTS.md`）
- 进入该目录开始对话即可，无需再粘贴背景

### 2. 网页版 AI（ChatGPT / Claude / Gemini / Kimi / 豆包）

二选一：

1. **轻量**：把 [`prompts/context-pack.md`](prompts/context-pack.md) 全文粘贴到对话开头
2. **长期**：新建 Project / Gem / 智能体，把 `AGENTS.md` + `profile/*.md` 加进知识库

### 3. 新电脑

```bash
git clone https://github.com/yongruif533-tech/yongrui-brain.git
```

可选：配置定时自动同步，见 [`bootstrap/SETUP.md`](bootstrap/SETUP.md)。

## 维护协议（让大脑持续变大）

1. **只写事实**：不确定的内容标 `[待确认]`，推断的内容标 `[推断]`，并写清依据。
2. **记忆追加，不覆盖**：日志写 `memory/journal/YYYY-MM.md`，不删除旧条目。
3. **冲突优先级**：`profile/` > `memory/journal/` > AI 的推断。
4. **每次重要工作结束**：让 AI 按 `memory/README.md` 的格式写回，然后提交。
5. **提交信息**：`memory: <一句话>`，例如 `memory: 专利交底书定稿`。

## 目录导航

```
yongrui-brain/
├── AGENTS.md                 # ① 总入口：任何 AI 先读这个
├── CLAUDE.md                 # Claude Code 入口（指向 AGENTS.md）
├── .cursor/rules/brain.mdc   # Cursor 规则
├── profile/                  # ② 事实层（稳定信息）
│   ├── identity.md           # 身份、基本信息
│   ├── education.md          # 教育背景
│   ├── research.md           # 科研与项目经历
│   ├── skills.md             # 技能矩阵
│   ├── publications.md       # 论文、软著、专利、荣誉
│   ├── goals.md              # 目标与规划
│   └── working-style.md      # 工作风格与协作偏好
├── memory/                   # ③ 记忆层（持续累积）
│   ├── README.md             # 写回格式与规则
│   ├── journal/              # 月度日志
│   ├── projects/             # 进行中项目快照
│   └── decisions/            # 重要决策记录
├── prompts/                  # ④ 可直接粘贴的提示词
│   ├── system-prompt.md      # 完整版系统提示
│   └── context-pack.md       # 轻量上下文包
├── bootstrap/SETUP.md        # 各平台接入指南
├── resume/resume_public.md   # 脱敏版简历（Markdown）
├── data/profile.yaml         # 机器可读档案
└── scripts/                  # 同步脚本（PowerShell / Bash）
```

## 隐私边界

- 本仓库为 **公开仓库**，**不含**手机号、邮箱、身份证号、住址门牌、患者个体数据。
- 需要保存的联系方式等敏感信息放在本地 `private/` 目录（已在 `.gitignore` 中排除）。
- 若希望完全私有：把仓库改为 Private，其余用法不变；网页版 AI 将无法通过公开链接读取，需要改用 Project 上传或本地工具。
- 引用本仓库中的科研内容时，请以可核查的原文/数据库为准。

## 路线图

- [x] v1.0：事实层 + 记忆层 + 接口层
- [ ] 补充 `[待确认]` 项（GPA、专利号、GitHub 主页、保研意向）
- [ ] GitHub Action：提交时自动生成/校验 `context-pack.md`
- [ ] 可选：MCP server，让任意 AI 客户端直接查询本档案

---

个人内容，保留所有权利（All rights reserved）。未经本人许可，请勿转载或用于训练。
