# 项目状态：Relicbound

最后更新：2026-06-25

## 当前阶段

当前里程碑：**M3：敌人 AI 与掉落系统**

当前状态：**M3 第一版打怪掉落拾取循环已提交，等待用户本地 Godot 运行验证**

## 项目基本信息

- 项目名：Relicbound
- 中文名：遗物之契
- 仓库：98longq/relicbound
- 引擎：Godot 4.x
- 语言：GDScript
- 类型：2D 横板动作刷宝 Roguelite
- 当前目标：验证敌人追踪、敌人攻击玩家、玩家生命值、敌人死亡掉金币、玩家拾取金币

## 已完成

### M0：项目规划与基础框架

- [x] 确定游戏方向：2D 横板动作 + 打怪掉宝 + Roguelite 构筑
- [x] 确定项目名：Relicbound / 遗物之契
- [x] 创建 GitHub 仓库
- [x] 添加 README
- [x] 添加 `.gitignore`
- [x] 添加 `project.godot`
- [x] 添加占位项目图标 `icon.svg`
- [x] 添加测试关卡占位场景 `scenes/levels/test_level.tscn`
- [x] 添加游戏设计文档 `docs/GAME_DESIGN.md`
- [x] 添加技术设计文档 `docs/TECHNICAL_DESIGN.md`
- [x] 添加开发路线图 `docs/ROADMAP.md`
- [x] 添加项目状态文档 `docs/PROJECT_STATUS.md`
- [x] 添加开发日志 `docs/DEVELOPMENT_LOG.md`
- [x] 添加开发流程文档 `docs/WORKFLOW.md`
- [x] 添加 AI 协作上下文 `docs/AI_CONTEXT.md`
- [x] 添加内容制作规范 `docs/CONTENT_PIPELINE.md`
- [x] 补齐基础目录结构

### M1：角色基础控制原型

- [x] 创建玩家控制脚本 `scripts/player/player_controller.gd`
- [x] 创建玩家场景 `scenes/player/player.tscn`
- [x] 将测试关卡 `scenes/levels/test_level.tscn` 扩展为可运行原型场景
- [x] 在测试关卡中加入玩家实例
- [x] 在测试关卡中加入地面和平台碰撞
- [x] 实现左右移动
- [x] 实现跳跃和重力
- [x] 实现落地检测
- [x] 实现角色朝向反馈
- [x] 添加玩家摄像机跟随
- [x] 添加 A/D、方向键、Space、Godot UI action 的输入兜底

### M2：基础战斗闭环

- [x] 扩展 `scripts/player/player_controller.gd`，加入最小近战攻击逻辑
- [x] 扩展 `scenes/player/player.tscn`，加入 `AttackArea` 攻击判定区域
- [x] 创建敌人基础脚本 `scripts/enemies/enemy_base.gd`
- [x] 创建测试敌人场景 `scenes/enemies/test_enemy.tscn`
- [x] 敌人支持最大生命、当前生命、受击闪白和死亡消失
- [x] 测试敌人支持基础重力和落地
- [x] 测试关卡中放置测试敌人
- [x] 玩家可通过 J 或鼠标左键触发攻击
- [x] 攻击命中敌人后造成伤害并更新敌人血量显示

### M3：敌人 AI 与掉落系统

- [x] 玩家拥有生命值、金币数量和状态显示
- [x] 玩家支持 `apply_damage()`，可被敌人攻击扣血
- [x] 玩家死亡后变灰，按 R 可重载当前场景
- [x] 玩家支持 `collect_pickup()`，可拾取金币或生命类物品
- [x] 敌人基础脚本加入简单追踪 AI
- [x] 敌人靠近玩家后按冷却造成接触范围伤害
- [x] 敌人死亡时可生成掉落物
- [x] 创建通用拾取物脚本 `scripts/loot/pickup_item.gd`
- [x] 创建金币拾取物场景 `scenes/items/pickup_gold.tscn`
- [x] 测试敌人配置为 100% 掉落金币

## 正在进行

- [ ] 用户本地用 Godot 4.x 打开项目并运行主场景
- [ ] 验证敌人是否会靠近玩家
- [ ] 验证敌人靠近后是否会扣玩家 HP
- [ ] 验证玩家死亡后是否可按 R 重开
- [ ] 验证敌人死亡后是否掉落金币
- [ ] 验证玩家碰到金币后 Gold 数量是否增加

## 下一步任务

M3 验证通过后，进入 M4：装备与背包原型。

M4 首要任务：

1. 创建物品和装备数据结构。
2. 创建基础背包数据容器。
3. 创建装备栏数据结构。
4. 创建一个测试装备掉落物。
5. 实现拾取装备进入背包。
6. 实现装备后修改玩家攻击力或生命值。
7. 同步更新 `docs/PROJECT_STATUS.md` 和 `docs/DEVELOPMENT_LOG.md`。

## 当前阻塞点

暂无代码层面的阻塞。

需要用户本地确认的事项：

- 克隆仓库后是否能用 Godot 4.x 打开项目。
- 主场景是否能正常运行。
- 玩家是否能移动、跳跃、攻击。
- 敌人是否能追踪并攻击玩家。
- 敌人死亡后是否掉落金币。
- 玩家拾取金币后状态栏 Gold 是否增加。

## 开发同步规则

每次开发结束后，必须同步更新：

1. `docs/PROJECT_STATUS.md`：更新当前状态、已完成、下一步、阻塞点。
2. `docs/DEVELOPMENT_LOG.md`：追加本次变更记录。
3. 必要时更新：
   - `docs/GAME_DESIGN.md`
   - `docs/TECHNICAL_DESIGN.md`
   - `docs/ROADMAP.md`
   - `docs/AI_CONTEXT.md`
   - `README.md`

## 最近一次更新摘要

2026-06-25：完成 M3 第一版打怪掉落拾取循环。敌人可简单追踪玩家并造成伤害，玩家拥有生命和金币状态，敌人死亡后掉落金币，玩家碰到金币后可拾取并增加金币数。当前等待用户本地 Godot 运行验证，验证通过后进入 M4 装备与背包原型。
