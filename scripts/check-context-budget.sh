#!/bin/bash
# check-context-budget.sh - 检查上下文预算是否超标
# 主脑侧上限：24KB，执行器侧上限：12KB

set -e

BASE_RULES="rules/base.md"
TOOL_RULES="rules/by-tool"
ROLE_RULES="rules/by-role"

# 计算主脑侧总量（base + 所有 tool + 所有 role）
main_brain_size=$(cat "$BASE_RULES" $(ls $TOOL_RULES/*.md 2>/dev/null) $(ls $ROLE_RULES/*.md 2>/dev/null) 2>/dev/null | wc -c)

# 计算执行器侧总量（base + 当前工具段）
# 默认按 Claude Code 计算，可通过参数指定工具
TOOL_NAME=${1:-"claude-code"}
executor_size=$(cat "$BASE_RULES" "$TOOL_RULES/$TOOL_NAME.md" 2>/dev/null | wc -c)

echo "=== 上下文预算检查 ==="
echo ""
echo "主脑侧: $main_brain_size bytes (上限 24576 bytes / 24KB)"
echo "执行器侧 ($TOOL_NAME): $executor_size bytes (上限 12288 bytes / 12KB)"
echo ""

# 检查主脑侧
if [ "$main_brain_size" -gt 24576 ]; then
    echo "❌ 主脑侧超标！超出 $((main_brain_size - 24576)) bytes"
    echo "   建议：删除 or 精简 rules/ 下的文件"
    exit 1
else
    echo "✓ 主脑侧在预算内"
fi

# 检查执行器侧
if [ "$executor_size" -gt 12288 ]; then
    echo "❌ 执行器侧 ($TOOL_NAME) 超标！超出 $((executor_size - 12288)) bytes"
    echo "   建议：精简 $TOOL_RULES/$TOOL_NAME.md"
    exit 1
else
    echo "✓ 执行器侧 ($TOOL_NAME) 在预算内"
fi

echo ""
echo "=== 检查通过 ==="
exit 0
