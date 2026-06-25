# 技术设计文档：Relicbound

最后更新：2026-06-25
当前阶段：M0 项目规划与基础框架

## 1. 技术栈

- 引擎：Godot 4.x
- 脚本语言：GDScript
- 目标平台：PC 优先
- 版本管理：Git + GitHub

Godot 4 适合 2D 横板动作游戏，工程轻量，资源结构清晰，便于快速迭代。

## 2. 总体架构原则

1. 场景负责组合，脚本负责逻辑。
2. 玩家、敌人、掉落物、UI、数据系统互相解耦。
3. 不把所有逻辑写进单个 Player 脚本。
4. 通用逻辑放入 `scripts/systems/` 或 `scripts/combat/`。
5. 装备、怪物、遗物等内容尽量数据化。
6. 每个里程碑结束都要更新文档和项目状态。

## 3. 目录说明

```text
scenes/player/      玩家相关场景
scenes/enemies/     敌人和 Boss 场景
scenes/levels/      关卡、房间和测试地图
scenes/ui/          HUD、背包、菜单等 UI
scenes/items/       掉落物、装备拾取物等场景

scripts/player/     玩家控制、状态、输入处理
scripts/enemies/    敌人 AI、敌人状态、Boss 行为
scripts/combat/     伤害、命中盒、受击盒、战斗计算
scripts/loot/       掉落表、掉落生成、拾取逻辑
scripts/inventory/  背包、装备栏、物品数据
scripts/systems/    全局系统、事件总线、存档、场景切换

assets/sprites/     图片资源
assets/audio/       音效和音乐
assets/fonts/       字体
assets/effects/     特效资源

data/items/         装备和物品数据
data/enemies/       敌人配置数据
data/relics/        遗物配置数据
```

## 4. 核心场景规划

### 4.1 玩家场景

路径：`scenes/player/player.tscn`

建议节点结构：

```text
Player (CharacterBody2D)
├── Sprite2D / AnimatedSprite2D
├── CollisionShape2D
├── AttackArea (Area2D)
│   └── CollisionShape2D
├── Hurtbox (Area2D)
│   └── CollisionShape2D
├── Camera2D
└── StateTimer / CooldownTimer
```

玩家脚本拆分方向：

- `scripts/player/player_controller.gd`：移动、跳跃、朝向、基础状态。
- `scripts/player/player_combat.gd`：攻击、闪避、受击、死亡。
- `scripts/player/player_stats.gd`：生命、攻击力、速度等属性。

MVP 可以先合并为较少脚本，等逻辑复杂后再拆分。

### 4.2 敌人场景

基础敌人路径示例：`scenes/enemies/slime.tscn`

建议节点结构：

```text
Enemy (CharacterBody2D)
├── Sprite2D / AnimatedSprite2D
├── CollisionShape2D
├── AttackArea (Area2D)
├── Hurtbox (Area2D)
└── Timers
```

敌人脚本：

- `scripts/enemies/enemy_base.gd`
- `scripts/enemies/enemy_chaser.gd`
- `scripts/enemies/enemy_ranged.gd`
- `scripts/enemies/boss_ruin_guardian.gd`

### 4.3 关卡场景

MVP 测试关卡路径：`scenes/levels/test_level.tscn`

节点结构：

```text
TestLevel (Node2D)
├── TileMapLayer / StaticBody2D Platforms
├── PlayerSpawn
├── EnemySpawns
├── ItemSpawns
├── UI
└── WorldBoundary
```

## 5. 战斗系统设计

### 5.1 伤害数据

建议后续建立统一伤害数据结构：

```gdscript
var damage_data = {
    "amount": 10,
    "source": self,
    "damage_type": "physical",
    "knockback": Vector2.ZERO,
    "can_crit": true
}
```

### 5.2 Hitbox / Hurtbox

- Hitbox：攻击判定区域。
- Hurtbox：受击判定区域。
- 攻击命中时由 Hitbox 传递伤害数据给 Hurtbox。

这样玩家、敌人、陷阱和 Boss 都可以共用伤害流程。

## 6. 属性系统

基础属性：

```text
max_health
current_health
attack_power
defense
move_speed
jump_velocity
attack_speed
crit_chance
crit_damage
dash_cooldown
```

后续装备和遗物都应该修改属性或监听事件，而不是直接改写战斗流程。

## 7. 掉落系统

MVP 掉落流程：

```text
敌人死亡 → 读取掉落表 → 计算掉落结果 → 实例化掉落物场景 → 玩家靠近拾取
```

相关脚本规划：

- `scripts/loot/loot_table.gd`
- `scripts/loot/loot_dropper.gd`
- `scripts/loot/pickup_item.gd`

## 8. 背包和装备系统

MVP 可以先实现简单版本：

- 背包是数组。
- 装备栏是字典。
- 物品数据用 Dictionary 或 Resource 保存。
- 拾取装备后直接进入背包。
- 点击装备后替换当前装备并刷新属性。

后续再扩展排序、对比、出售、锁定、分解等功能。

## 9. 数据文件规划

数据文件可先使用 JSON，后续视情况改成 Godot Resource。

示例：`data/items/weapons.json`

```json
[
  {
    "id": "rusted_sword",
    "name": "生锈短剑",
    "slot": "weapon",
    "rarity": "common",
    "base_stats": {
      "attack_power": 5
    }
  }
]
```

## 10. UI 系统

MVP UI 包含：

- 血条
- 金币数量
- 当前装备提示
- 拾取提示
- 死亡界面

后续扩展：

- 背包界面
- 装备对比
- 遗物栏
- 暂停菜单
- 设置菜单

## 11. 保存系统

MVP 阶段暂不做复杂存档。

后续可保存：

- 已解锁角色
- 图鉴
- 设置
- 永久成长
- 最近一次通关记录

## 12. 初期开发顺序

1. 项目文档和目录结构。
2. Godot 工程入口。
3. 玩家移动和测试关卡。
4. 基础攻击与敌人受击。
5. 敌人追踪和攻击。
6. 掉落物和拾取。
7. 简单 UI。
8. Boss 和 Demo 闭环。

## 13. 风险点

| 风险 | 应对 |
|---|---|
| 系统过早复杂化 | 每阶段只做最小可玩功能 |
| 手感不好 | 优先迭代移动、攻击、受击反馈 |
| 文档和代码脱节 | 每次改动必须更新状态和日志 |
| 内容太多做不完 | MVP 只保留必要怪物、装备和关卡 |
| 资源制作压力大 | 初期使用占位图形和简单特效 |
