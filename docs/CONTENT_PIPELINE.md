# 内容制作与资源规范

最后更新：2026-06-25

## 1. 目标

本文件用于规范 Relicbound 的资源、数据、命名和内容制作方式，避免后续项目变大后资源混乱。

## 2. 命名原则

统一使用小写英文和下划线：

```text
player_controller.gd
ruin_guardian.tscn
rusted_sword.json
small_crawler.png
```

不要使用：

- 中文文件名
- 空格
- 特殊符号
- 过长文件名

## 3. 场景命名

| 类型 | 示例 |
|---|---|
| 玩家 | `player.tscn` |
| 敌人 | `enemy_crawler.tscn` |
| Boss | `boss_ruin_guardian.tscn` |
| 掉落物 | `pickup_gold.tscn` |
| 关卡 | `test_level.tscn` |
| UI | `hud.tscn` |

## 4. 脚本命名

| 类型 | 示例 |
|---|---|
| 玩家控制 | `player_controller.gd` |
| 玩家属性 | `player_stats.gd` |
| 敌人基础类 | `enemy_base.gd` |
| 伤害区域 | `hitbox.gd` |
| 受击区域 | `hurtbox.gd` |
| 掉落表 | `loot_table.gd` |
| 背包 | `inventory.gd` |

## 5. 数据命名

物品 ID 使用小写英文和下划线：

```text
rusted_sword
iron_helmet
bloodfang_necklace
thunder_core
```

怪物 ID：

```text
small_crawler
skeleton_warrior
skeleton_archer
shield_guard
ruin_guardian
```

## 6. 资源目录

```text
assets/sprites/characters/
assets/sprites/enemies/
assets/sprites/items/
assets/sprites/ui/
assets/audio/sfx/
assets/audio/music/
assets/fonts/
assets/effects/
```

当前仓库先保留大类目录，等资源增加后再细分。

## 7. 初期占位资源策略

M0-M2 阶段不追求正式美术。

可以使用：

- Godot 基础图形
- 简单矩形和圆形
- 纯色占位图
- 免费临时音效

正式美术资源在玩法闭环稳定后再制作或替换。

## 8. 装备数据建议格式

初期可以使用 JSON：

```json
{
  "id": "rusted_sword",
  "name": "生锈短剑",
  "slot": "weapon",
  "rarity": "common",
  "base_stats": {
    "attack_power": 5
  },
  "tags": ["sword", "starter"]
}
```

后续可以改为 Godot Resource，方便编辑器内调整。

## 9. 怪物数据建议格式

```json
{
  "id": "small_crawler",
  "name": "小型爬虫",
  "max_health": 20,
  "attack_power": 5,
  "move_speed": 80,
  "loot_table": "crawler_basic"
}
```

## 10. 遗物数据建议格式

```json
{
  "id": "thunder_core",
  "name": "雷鸣核心",
  "rarity": "relic",
  "description": "普通攻击有概率召唤落雷。",
  "trigger": "on_attack_hit",
  "effect": "spawn_lightning"
}
```

## 11. UI 文案规范

UI 文案先使用中文。

后续如果需要多语言，统一迁移到翻译表。

## 12. 音效规范

音效命名示例：

```text
sfx_player_attack_01.wav
sfx_enemy_hit_01.wav
sfx_loot_drop_01.wav
sfx_boss_roar_01.wav
```

## 13. 版本迭代原则

资源和数据不要一次性做太多。

每个阶段只添加支撑当前玩法闭环所需的内容。

MVP 资源优先级：

1. 玩家占位图
2. 平台和地面占位图
3. 1-3 种敌人占位图
4. 掉落物图标
5. 基础 UI
6. Boss 占位图
