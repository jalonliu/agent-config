#!/bin/bash
# scheduler - 主脑调度执行器框架
# 用法: bash scripts/scheduler/scheduler.sh "任务描述" [执行器模型]
#
# 流程：
# 1. 主脑拆分子任务
# 2. 生成任务卡
# 3. 派发给 Pi 执行器
# 4. 主脑验收并汇总

TASK="${1:-}"
EXECUTOR_MODEL="${2:-deepseek-v4.1-flash-free}"

if [ -z "$TASK" ]; then
    echo "Usage: $0 '任务描述' [执行器模型]"
    echo ""
    echo "Example:"
    echo "  $0 '修复用户支付卡住 bug，62 天无人处理'"
    exit 1
fi

TASK_CARD="./scripts/scheduler/task-card-$(date +%Y%m%d-%H%M%S).md"

cat > "$TASK_CARD" <<EOF
# 任务卡

## 任务
$TASK

## 约束
- 严格按任务卡执行，不自行扩展
- 遇到歧义向主脑请示，不猜测
- 完成后按验收标准自检

## 验收标准
- [ ] 任务完成
- [ ] 无副作用
- [ ] 记录执行过程

## 已知背景
- 主脑已拆分子任务
- 执行器上下文精简（约 7KB）
- 使用 Flash 级模型（已跨 Coding 基准线）

## 执行器配置
- 外壳：Pi
- 模型：$EXECUTOR_MODEL
- Skill 加载：关闭
EOF

echo "任务卡已生成: $TASK_CARD"
echo ""
echo "下一步：用 Pi 执行此任务卡"
echo "  cd <project> && pi --task-card $TASK_CARD"
