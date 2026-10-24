#!/bin/bash
# advisor tool - 顾问模式工具
# 用法: bash scripts/advisor/advisor.sh "问题描述" "干净上下文" [模型]
# 
# 设计原则：
# 1. 给顾问干净的独立上下文（不背会话历史）
# 2. 只带必要背景，不超过 12KB
# 3. 顾问意见需要验证，不是最终答案

QUESTION="${1:-}"
CONTEXT="${2:-}"
MODEL="${3:-openco-zen/deepseek-v4.1-flash-free}"  # 默认用免费模型做快速顾问

if [ -z "$QUESTION" ]; then
    echo "Usage: $0 '问题描述' '干净上下文' [模型]"
    echo ""
    echo "Example:"
    echo "  $0 '这个 PR 该合并吗？' 'PR 改了 3 个文件，修复了用户支付卡住 62 天的 bug'"
    exit 1
fi

echo "=== Advisor 咨询 ==="
echo "问题: $QUESTION"
echo "上下文长度: $(echo -n "$CONTEXT" | wc -c) bytes"
echo ""
echo "请基于以下干净上下文给出判断建议："
echo "---"
echo "$CONTEXT"
echo "---"
echo ""
echo "问题：$QUESTION"
echo ""
echo "请以简洁的方式给出判断，并说明理由。"

# TODO: 接入实际 API 调用
# curl -s https://api.openai.com/v1/chat/completions \
#   -H "Authorization: Bearer $OPENAI_API_KEY" \
#   -d "{\"model\": \"$MODEL\", \"messages\": [{\"role\": \"user\", \"content\": \"$CONTEXT\n\n问题：$QUESTION\"}]}"
