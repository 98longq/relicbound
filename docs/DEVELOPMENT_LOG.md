# 开发日志：Relicbound

本文件用于记录每次重要开发变更。后续每次功能开发、重构、文档调整、系统设计变化，都应该追加记录。

## 日志格式

```markdown
## YYYY-MM-DD：标题

### 变更内容

- ...

### 影响范围

- ...

### 下一步

- ...
```

---

## 2026-06-25：项目文档与基础框架初始化

### 变更内容

- 创建项目 README。
- 创建 Godot 4 基础工程文件 `project.godot`。
- 创建 `.gitignore`。
- 创建占位项目图标 `icon.svg`。
- 创建测试关卡占位场景 `scenes/levels/test_level.tscn`。
- 创建游戏设计文档 `docs/GAME_DESIGN.md`。
- 创建技术设计文档 `docs/TECHNICAL_DESIGN.md`。
- 创建路线图 `docs/ROADMAP.md`。
- 创建项目状态文档 `docs/PROJECT_STATUS.md`。
- 创建开发日志 `docs/DEVELOPMENT_LOG.md`。
- 创建开发流程文档 `docs/WORKFLOW.md`。
- 创建 AI 协作上下文 `docs/AI_CONTEXT.md`。
- 创建内容制作规范 `docs/CONTENT_PIPELINE.md`。
- 创建基础目录结构：场景、脚本、资源、数据目录。
- 建立后续开发必须同步更新文档的规则。

### 影响范围

- 仓库从空仓库变为可持续开发的游戏项目骨架。
- 后续开发可以围绕文档进行，不依赖单次对话上下文。
- 初步确定项目方向为 2D 横板动作刷宝 Roguelite。
- Godot 工程已有最小入口文件，但尚未经过用户本地打开验证。
- 项目已有测试关卡占位场景，下一步可直接进入玩家控制器开发。

### 下一步

- 用户本地用 Godot 4.x 打开项目并确认工程可识别。
- 开始 M1：玩家基础控制原型。
- 创建玩家场景 `scenes/player/player.tscn`。
- 创建玩家控制脚本 `scripts/player/player_controller.gd`。
- 实现移动、跳跃、重力、落地检测和摄像机跟随。

---

## 2026-06-25：M1 玩家基础控制原型

### 变更内容

- 创建 `scripts/player/player_controller.gd`。
- 创建 `scenes/player/player.tscn`。
- 将 `scenes/levels/test_level.tscn` 从空场景扩展为可运行测试关卡。
- 测试关卡中加入玩家实例、地面和三段平台。
- 玩家控制器实现左右移动、跳跃、重力、落地检测和摩擦减速。
- 玩家场景添加 `Camera2D`，用于基础摄像机跟随。
- 玩家视觉使用 `ColorRect` 占位块，暂不引入正式美术资源。
- 输入支持项目动作 `move_left`、`move_right`、`jump`，并加入 A/D、方向键、Space 和 Godot UI action 兜底。

### 影响范围

- 项目从纯文档框架进入可运行玩法原型阶段。
- 主场景 `test_level.tscn` 已具备基础平台测试条件。
- M1 的核心功能已提交，但仍需用户本地 Godot 运行验证。
- 正式攻击、敌人、血量、掉落等内容尚未开始，留给 M2-M3。

### 下一步

- 用户本地用 Godot 4.x 打开项目并运行主场景。
- 验证 A/D 或方向键移动是否正常。
- 验证 Space 跳跃、落地检测和平台碰撞是否正常。
- 验证摄像机是否跟随玩家。
- 如果 M1 运行正常，进入 M2：基础战斗闭环。
