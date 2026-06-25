# 开发协作流程

最后更新：2026-06-25

## 1. 目标

本文件规定 Relicbound 项目的开发方式，核心目标是：

1. 避免开发中断后丢失上下文。
2. 让代码、文档、进度始终保持同步。
3. 每次开发都能清楚知道做了什么、为什么做、下一步做什么。

## 2. 每次开发前

开始任何新功能前，先检查：

1. `docs/PROJECT_STATUS.md`：确认当前阶段、已完成、下一步。
2. `docs/ROADMAP.md`：确认本次任务属于哪个里程碑。
3. `docs/TECHNICAL_DESIGN.md`：确认相关系统的设计边界。
4. 如果涉及玩法变化，检查 `docs/GAME_DESIGN.md`。

## 3. 每次开发中

开发时遵循：

- 一次只做一个明确目标。
- 优先完成最小可用版本。
- 避免过早封装复杂系统。
- 代码命名必须清楚表达职责。
- 如果实际实现和文档不一致，以实际需求为准，但必须同步更新文档。

## 4. 每次开发后

每次功能完成后必须更新：

### 必须更新

- `docs/PROJECT_STATUS.md`
- `docs/DEVELOPMENT_LOG.md`

### 视情况更新

- `docs/GAME_DESIGN.md`
- `docs/TECHNICAL_DESIGN.md`
- `docs/ROADMAP.md`
- `README.md`
- `docs/AI_CONTEXT.md`

## 5. 文档更新规则

### PROJECT_STATUS.md

记录当前真实状态：

- 当前阶段
- 已完成
- 正在进行
- 下一步任务
- 阻塞点
- 最近一次更新摘要

### DEVELOPMENT_LOG.md

记录历史变化：

- 本次改了什么
- 影响了哪些系统
- 下一步要做什么

### AI_CONTEXT.md

用于后续 AI 协作快速恢复上下文。

每当项目方向、架构、阶段目标发生变化，都要更新该文件。

## 6. 推荐开发节奏

建议每次开发控制在一个小目标内，例如：

- 只实现玩家移动。
- 只实现跳跃。
- 只实现敌人受击。
- 只实现金币掉落。

不要一次同时做玩家、敌人、掉落、背包、Boss。

## 7. 提交信息规范

推荐提交信息格式：

```text
Add player movement prototype
Add basic enemy health system
Add loot pickup scene
Update project status for M1
```

中文也可以，但建议简短明确：

```text
添加玩家移动原型
添加基础敌人血量系统
更新 M1 项目状态
```

## 8. 分支策略

当前早期阶段可以直接在 `main` 上开发。

当项目功能变复杂后，建议使用分支：

```text
feature/player-controller
feature/combat-system
feature/loot-system
feature/inventory-ui
```

重要功能可以通过 Pull Request 合并。

## 9. 质量标准

每个可玩功能至少满足：

1. 能在 Godot 中运行。
2. 没有明显报错。
3. 文档记录已更新。
4. 下一步任务明确。

## 10. 当前阶段特殊规则

M0 / M1 阶段优先级：

1. 让工程可打开。
2. 让角色可动。
3. 让测试关卡可跑。
4. 再做战斗。

不做以下内容：

- 复杂装备 UI
- 大量美术资源
- 完整剧情
- 联机
- 随机地图
