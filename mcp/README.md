# MCP Servers - 项目级别控制
#
# 原则：有 CLI 就用 CLI，MCP 非必要不开
# 这里只放真正需要的 MCP 服务器配置

## 示例配置
# server-name:
#   command: npx
#   args: ["-y", "some-mcp-server"]
#   env:
#     API_KEY: ${API_KEY}  # 从 .env 读取
