# Claude Code Rules

## 上下文构建

- 系统提示默认即可，不需要大幅修改
- CLAUDE.md 已兼容 AGENTS.md（无 CLAUDE.md 时直接读 AGENTS.md）
- Skill 按需加载，不在全局加载无关 Skill

## 记忆系统

- **建议关闭自带记忆**，改用 `agent-config/memory/` 跨 Agent 共享
- 原因：多工具场景下 Claude 记忆无法同步到其他 Agent

## Skill 管理

- 项目级 Skill 开关：在仓库 `.claude/` 目录下配置
- 全局 Skill 仅保留高频通用
- 排查启动上下文时检查 Skill 重复注入

## 行为轨迹

- 默认 30 天自动删除，建议修改配置长期保留
- 修改方式：`claude config set telemetry.enabled true`

## Advisor 模式

- 原生 Advisor 工具仅限 Claude Code 使用
- 也可使用 `agent-config/scripts/advisor/` 独立工具

## 提交规范

- Commit message 遵循 Conventional Commits
- PR 描述包含上下文预算变化

## License

MIT
