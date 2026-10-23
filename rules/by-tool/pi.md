# Pi Rules - 执行器外壳

## 定位

Pi 作为 Claude Code 和 Codex 的子代理，执行主脑拆分的子任务。

## 上下文优势

- 系统提示可完全定制
- 只注入任务卡需要的内容
- 关闭 Skill 加载，节省上下文

## 配置建议

```yaml
# pi_config.yaml
model: deepseek-v4.1-flash-free  # 或其他 Flash 级模型
context_budget: 12KB              # 执行器侧硬闸
skill_loading: off                # 执行器不需要 Skill
```

## 与主脑协作

1. 主脑（Claude Code/Codex）拆分子任务
2. 生成任务卡（包含上下文约束）
3. Pi 执行任务卡，返回结果
4. 主脑验收并汇总

## 对比测试结果

- DeepSeek 模型在 Pi vs Claude Code：首轮输入从 1.75 万 Token 降到 8500
- 系统提示从 3.87 万字符降到 1.67 万
- 成本降低约 40%，质量持平略优

## License

MIT
