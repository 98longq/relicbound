# AI 协作上下文：Relicbound

最后更新：2026-06-25

本文件用于帮助后续 AI 或开发者快速恢复项目上下文。每次项目方向、架构、阶段目标或开发规则发生变化时，都应该更新本文件。

## 1. 项目一句话

Relicbound / 遗物之契 是一款使用 Godot 4 开发的 2D 横板动作刷宝 Roguelite 游戏，核心体验是横板动作打怪、随机掉落装备与遗物、构筑不同 Build 并挑战 Boss。

## 2. 当前仓库

- GitHub 仓库：`98longq/relicbound`
- 默认分支：`main`
- 当前阶段：M0 项目规划与基础框架
- 当前优先级：文档体系、工程结构、M1 玩家基础控制原型

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

1. M0：项目文档与基础框架。
2. M1：玩家基础控制原型。
3. M2：基础战斗闭环。
4. M3：敌人 AI 与掉落系统。
5. M4：装备与背包原型。
6. M5：Boss 与 Demo 闭环。
7. M6：遗物系统与 Build 雏形。
8. M7：房间式关卡与内容扩展。

## 8. 下一次开发建议

如果用户说“继续开发”或“开始下一步”，优先执行 M1：玩家基础控制原型。

M1 首要任务：

1. 创建 `scenes/levels/test_level.tscn`。
2. 创建 `scenes/player/player.tscn`。
3. 创建 `scripts/player/player_controller.gd`。
4. 配置 InputMap。
5. 实现左右移动、跳跃、重力、摄像机跟随。
6. 更新 `docs/PROJECT_STATUS.md` 和 `docs/DEVELOPMENT_LOG.md`。

## 9. 开发注意事项

- 不要一开始做复杂背包、随机地图和大量装备。
- 不要把所有逻辑写在一个脚本里。
- 先做最小可玩闭环。
- 每次结束必须说明本次改动和下一步。
- 任何设计变更都要同步进文档。

## 10. 当前已知限制

- 仓库刚初始化，尚未经过本地 Godot 打开测试。
- `project.godot` 是最小工程配置，后续需要随着场景创建继续调整。
- 美术资源暂未制作，初期应使用占位图形。
