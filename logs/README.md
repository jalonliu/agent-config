# 行为轨迹日志
# 记录 Agent 的所有行为数据，用于复盘和回测

## 日志格式

每条日志包含：
- timestamp: ISO 8601 时间戳
- agent: 执行者（主脑/执行器名称）
- action: 行为类型（commit/review/decision/error）
- context_size: 当时上下文大小（bytes）
- tokens_used: Token 消耗
- outcome: 结果（success/failure）
- notes: 备注

## 日志文件

按日期分文件：`YYYY-MM-DD.jsonl`

## 保留策略

- 长期保留（不做自动删除）
- 定期归档到压缩格式节省空间
