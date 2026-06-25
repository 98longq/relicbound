# AI 协作上下文：Relicbound

最后更新：2026-06-25

本文件用于帮助后续 AI 或开发者快速恢复项目上下文。每次项目方向、架构、阶段目标或开发规则发生变化时，都应该更新本文件。

## 1. 项目一句话

Relicbound / 遗物之契 是一款使用 Godot 4 开发的 2D 横板动作刷宝 Roguelite 游戏，核心体验是横板动作打怪、随机掉落装备与遗物、构筑不同 Build 并挑战 Boss。

## 2. 当前仓库

- GitHub 仓库：`98longq/relicbound`
- 默认分支：`main`
- 当前阶段：M3 敌人 AI 与掉落系统
- 当前优先级：用户本地运行验证 M3；验证通过后进入 M4 装备与背包原型

## 3. 用户的长期开发要求

用户明确希望：

1. 先把开发文档规划好。
2. 搭好项目框架。
3. 将文档和框架形成文件放入 GitHub 仓库。
4. 后续开发根据开发文档推进。
5. 每次更新项目时，同步更新一份说明或进度记录。
6. 这样即使开发中断，也能根据文档和项目进度快速继续。

因此，后续开发时不能只改代码。每次重要开发都要更新：

- `docs/PROJECT_STATUS.md`
- `docs/DEVELOPMENT_LOG.md`

必要时还要更新：

- `docs/GAME_DESIGN.md`
- `docs/TECHNICAL_DESIGN.md`
- `docs/ROADMAP.md`
- `docs/AI_CONTEXT.md`

## 4. 游戏设计核心

类型：2D 横板动作 + 打怪掉宝 + Roguelite 构筑。

核心循环：

```text
进入关卡 → 移动/跳跃/攻击/闪避 → 击败怪物 → 掉落金币/装备/遗物 → 构筑 Build → 挑战 Boss
```

核心系统：

- 玩家移动
- 玩家攻击
- 敌人 AI
- 血量和伤害
- 掉落系统
- 装备系统
- 遗物系统
- 背包 UI
- Boss 战
- 房间式关卡

## 5. 技术方向

- 引擎：Godot 4.x
- 脚本语言：GDScript
- 初期直接使用 GDScript，不使用 C#。
- 初期使用占位图形，优先完成玩法闭环。
- 数据可以先用 JSON 或 Dictionary，后续可迁移到 Godot Resource。

## 6. 已确定目录结构

```text
scenes/player/
scenes/enemies/
scenes/levels/
scenes/ui/
scenes/items/

scripts/player/
scripts/enemies/
scripts/combat/
scripts/loot/
scripts/inventory/
scripts/systems/

assets/sprites/
assets/audio/
assets/fonts/
assets/effects/

data/items/
data/enemies/
data/relics/
```

## 7. 当前路线

当前应按以下顺序推进：

1. M0：项目文档与基础框架。已基本完成。
2. M1：玩家基础控制原型。已提交。
3. M2：基础战斗闭环。最小战斗原型已提交。
4. M3：敌人 AI 与掉落系统。第一版循环已提交，等待用户本地运行验证。
5. M4：装备与背包原型。
6. M5：Boss 与 Demo 闭环。
7. M6：遗物系统与 Build 雏形。
8. M7：房间式关卡与内容扩展。

## 8. 当前已实现的 M1 内容

M1 已提交以下文件和功能：

- `scripts/player/player_controller.gd`
- `scenes/player/player.tscn`
- `scenes/levels/test_level.tscn`

当前玩法：

- 玩家使用 `CharacterBody2D`。
- 玩家视觉使用 `ColorRect` 占位块。
- 玩家碰撞使用 `CollisionShape2D`。
- 玩家内置 `Camera2D`。
- 测试关卡包含背景、玩家实例、地面和三段平台。
- 玩家支持左右移动、跳跃、重力、落地检测、摩擦减速。
- 玩家支持朝向反馈。
- 输入支持 `move_left`、`move_right`、`jump` 动作，并提供 A/D、方向键、Space、Godot UI action 兜底。

## 9. 当前已实现的 M2 内容

M2 已提交以下文件和功能：

- 扩展 `scripts/player/player_controller.gd`
- 扩展 `scenes/player/player.tscn`
- 新增 `scripts/enemies/enemy_base.gd`
- 新增 `scenes/enemies/test_enemy.tscn`
- 扩展 `scenes/levels/test_level.tscn`

当前玩法：

- 玩家按 J 或鼠标左键可以触发近战攻击。
- 玩家攻击时短暂启用 `AttackArea`。
- 攻击区域命中带有 `apply_damage` 方法的对象时造成伤害。
- 测试敌人拥有最大生命和当前生命。
- 测试敌人受击时闪白。
- 测试敌人上方显示生命值。
- 测试敌人生命归零后 `queue_free()` 死亡消失。
- 测试敌人已放入主测试关卡。

## 10. 当前已实现的 M3 内容

M3 已提交以下文件和功能：

- 扩展 `scripts/player/player_controller.gd`
- 扩展 `scenes/player/player.tscn`
- 扩展 `scripts/enemies/enemy_base.gd`
- 扩展 `scenes/enemies/test_enemy.tscn`
- 新增 `scripts/loot/pickup_item.gd`
- 新增 `scenes/items/pickup_gold.tscn`

当前玩法：

- 玩家拥有 HP 和 Gold 状态显示。
- 玩家可以被敌人调用 `apply_damage()` 扣血。
- 玩家生命归零后变灰，按 R 可重载当前场景。
- 玩家可以通过 `collect_pickup()` 拾取金币或生命类物品。
- 敌人在检测范围内会横向追踪玩家。
- 敌人靠近玩家后会按冷却造成伤害。
- 敌人死亡时会实例化配置的掉落场景。
- 测试敌人目前 100% 掉落金币。
- 金币拾取物碰到玩家后增加 Gold 并消失。

## 11. 下一次开发建议

如果用户反馈 M3 能正常运行，则优先进入 M4：装备与背包原型。

M4 首要任务：

1. 创建物品和装备数据结构。
2. 创建基础背包数据容器。
3. 创建装备栏数据结构。
4. 创建一个测试装备掉落物。
5. 实现拾取装备进入背包。
6. 实现装备后修改玩家攻击力或生命值。
7. 更新 `docs/PROJECT_STATUS.md` 和 `docs/DEVELOPMENT_LOG.md`。

如果用户反馈 M3 不能运行，则优先修复运行问题，不进入 M4。

## 12. 开发注意事项

- 不要一开始做复杂背包、随机地图和大量装备。
- 不要把所有逻辑写在一个脚本里。
- 先做最小可玩闭环。
- 每次结束必须说明本次改动和下一步。
- 任何设计变更都要同步进文档。

## 13. 当前已知限制

- M3 尚未经过用户本地 Godot 打开和运行验证。
- `project.godot` 仍是较小配置，后续可根据实际 Godot 版本调整。
- 正式 InputMap 键位绑定尚未在 Godot 编辑器内验证；控制器目前通过硬编码按键兜底保证可测试。
- 美术资源暂未制作，当前使用占位图形。
- 敌人 AI 只是简单横向追踪，没有平台寻路。
- 当前只有金币掉落，还没有血瓶、装备、背包和遗物。
