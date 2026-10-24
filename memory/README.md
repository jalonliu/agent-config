# Memory - 跨 Agent 共享记忆
#
# 格式：索引目录 + Markdown 文档
# 小项目不用 Memory，以代码库为准
#
# 治理原则：
# 1. 有增加、有更新、有删除
# 2. 不过期的内容才值得记忆
# 3. 问题通常不是"没搜到"，而是"把过期的笔记又塞回了对话"

## 索引格式
# memory/index.md:
# - [fact-001](fact-001.md) 用户偏好：喜欢简洁回复
# - [fact-002](fact-002.md) 环境事实：D 盘是主要工作盘

## 文档格式
# memory/fact-NNN.md:
# ---
# id: fact-NNN
# created: YYYY-MM-DD
# updated: YYYY-MM-DD
# expires: null  # 或具体日期
# source: <来源>
# ---
# 
# 事实内容...
