# agent-config

AI 工具规则与调度脚本的统一配置仓库。

## 理念

Context（上下文）+ Loop（闭环）是 Agent 时代的核心。这个仓库管理所有 AI 工具的规则文件、Skill 定义、MCP 配置和调度脚本，通过版本化迭代持续优化 Agent 的决策质量和 Token 效率。

## 仓库结构

```
agent-config/
├── AGENTS.md                  # 全局 Agent 行为契约（主脑层）
├── rules/                     # 规则文件分层存储
│   ├── base.md                # 共用底座规则
│   ├── by-tool/               # 按工具分层（claude-code.md, codex.md, pi.md 等）
│   └── by-role/               # 按角色分层（executor.md, advisor.md 等）
├── skills/                    # Skill 定义（项目级优先，全局仅高频通用）
│   ├── global/                # 全局 Skill（所有 Agent 通用、高频使用）
│   └── projects/              # 项目级 Skill（按仓库组织）
├── mcp/                       # MCP 服务器配置（非必要不开）
├── scripts/                   # 调度与自动化脚本
│   ├── scheduler/             # 主脑调度逻辑
│   ├── hooks/                 # Git hooks（门禁、验证）
│   └── advisor/               # Advisor 顾问模式工具
├── memory/                    # 跨 Agent 共享记忆（Markdown 文档索引）
├── logs/                      # 行为轨迹与回测日志
├── config.yaml                # 全局配置（非密钥）
└── .env                       # 密钥与环境变量（不进版本控制）
```

## 设计原则

1. **珍惜上下文窗口**：每个文件都要回答"它凭什么在这里"，剔除不必要的注入
2. **分层拼接**：主脑和执行器的上下文分开构建，按需加载而非全量注入
3. **注入量硬闸**：主脑侧不超过 24KB，执行器侧不超过 12KB，超了拒绝提交
4. **版本化管理**：所有规则、Skill、脚本进 Git，支持回测和回滚
5. **判据验证**：任何检查写完后，先喂已知为"否"的输入确认会变红

## 快速开始

```bash
# 查看当前规则注入量
cat rules/base.md rules/by-tool/*.md | wc -c

# 添加新规则前先检查总量
./scripts/check-context-budget.sh

# 运行门禁检查
git hook pre-commit
```

## 多工具适配

本仓库支持的工具：
- Claude Code（CLAUDE.md → AGENTS.md 兼容）
- Codex
- Pi（执行器外壳，上下文可完全定制）
- Cursor
- OpenCode
- Kimi
- Grok
- GLM / DeepSeek / MiniMax / Gemini

每个工具的适配规则放在 `rules/by-tool/` 下，主脑按需拼接。

## 贡献

所有改动通过 PR，AI 提交为主，人工审查兜底。提交前必须通过上下文预算检查和门禁测试。

## License

MIT
