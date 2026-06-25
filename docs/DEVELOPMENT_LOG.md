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

---

## 2026-06-25：M2 最小战斗原型

### 变更内容

- 扩展 `scripts/player/player_controller.gd`，加入最小近战攻击逻辑。
- 扩展 `scenes/player/player.tscn`，加入 `AttackArea`、攻击碰撞体和攻击可视化占位块。
- 创建 `scripts/enemies/enemy_base.gd`。
- 创建 `scenes/enemies/test_enemy.tscn`。
- 测试敌人拥有最大生命、当前生命、受击闪白、血量文本和死亡消失逻辑。
- 测试敌人支持基础重力和落地。
- 在 `scenes/levels/test_level.tscn` 中放置测试敌人。
- 玩家可通过 J 或鼠标左键触发攻击。

### 影响范围

- 项目进入最小战斗闭环阶段。
- 玩家已经可以对测试敌人造成伤害。
- 敌人血量会减少，受击时会闪白，生命归零后会从场景中移除。
- 当前敌人仍然不会追踪、不会攻击、不会掉落，这些留给 M3。
- 当前战斗仍未做连击、击退、无敌帧、伤害数字和音效，这些后续逐步加入。

### 下一步

- 用户本地用 Godot 4.x 运行主场景。
- 验证 J 或鼠标左键攻击是否能命中测试敌人。
- 验证敌人血量显示、受击闪白和死亡消失是否正常。
- 如果 M2 运行正常，进入 M3：敌人 AI 与掉落系统。

---

## 2026-06-25：M3 敌人 AI 与掉落拾取循环

### 变更内容

- 扩展 `scripts/player/player_controller.gd`，加入玩家生命值、金币数量、状态文本、受击、死亡和拾取逻辑。
- 扩展 `scenes/player/player.tscn`，加入 `StatusLabel` 显示 HP 和 Gold。
- 扩展 `scripts/enemies/enemy_base.gd`，加入简单追踪 AI、接近攻击、攻击冷却和死亡掉落。
- 创建 `scripts/loot/pickup_item.gd`，作为通用拾取物脚本。
- 创建 `scenes/items/pickup_gold.tscn`，作为金币拾取物。
- 扩展 `scenes/enemies/test_enemy.tscn`，配置金币掉落场景和掉落概率。

### 影响范围

- 项目形成第一版“敌人追踪 → 敌人攻击 → 玩家受伤 → 玩家击杀敌人 → 敌人掉落金币 → 玩家拾取金币”的循环。
- 玩家死亡后会变灰，并可按 R 重载当前场景。
- 金币会通过碰撞拾取并更新玩家状态栏。
- 当前掉落系统仍是最小实现，还没有掉落表、装备、稀有度、拾取提示或背包。
- 当前敌人 AI 是简单横向追踪，不包含寻路、跳跃、绕平台或复杂攻击模式。

### 下一步

- 用户本地用 Godot 4.x 运行主场景。
- 验证敌人是否能追踪并攻击玩家。
- 验证玩家 HP、死亡和按 R 重开是否正常。
- 验证击杀敌人后金币是否掉落，玩家碰到金币后 Gold 是否增加。
- 如果 M3 运行正常，进入 M4：装备与背包原型。
