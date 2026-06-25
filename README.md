# Relicbound / 遗物之契

Relicbound 是一款计划使用 Godot 4 开发的 2D 横板动作刷宝 Roguelite 游戏。

玩家扮演一名被远古遗物选中的契约者，进入崩塌的地下遗迹，与怪物战斗，收集装备与遗物，构筑不同战斗流派，并挑战强大的 Boss。

## 当前阶段

当前项目处于 **M0：项目规划与基础框架阶段**。

本阶段目标不是立刻堆功能，而是先建立稳定的开发文档、目录结构和协作流程。后续每次开发都必须同步更新项目状态和开发记录，保证项目中断后也能快速恢复上下文。

## 核心定位

- 类型：2D 横板动作 + 打怪掉宝 + Roguelite 构筑
- 引擎：Godot 4.x
- 平台：PC 优先，后续可考虑 Web / Steam / 移动端
- 第一阶段目标：完成一个 5-10 分钟可玩的 Demo

## 核心循环

```text
进入关卡 → 横板移动/跳跃/攻击/闪避 → 击败怪物 → 掉落装备/金币/遗物 → 形成 Build → 挑战 Boss → 解锁下一阶段
```

## 文档索引

- [`docs/GAME_DESIGN.md`](docs/GAME_DESIGN.md)：游戏设计文档，记录世界观、玩法、怪物、装备、遗物等设计。
- [`docs/TECHNICAL_DESIGN.md`](docs/TECHNICAL_DESIGN.md)：技术设计文档，记录 Godot 工程架构、脚本划分、数据结构和系统边界。
- [`docs/ROADMAP.md`](docs/ROADMAP.md)：开发路线图，记录阶段目标和里程碑。
- [`docs/PROJECT_STATUS.md`](docs/PROJECT_STATUS.md)：当前项目状态，记录最新完成内容、下一步任务和阻塞点。
- [`docs/DEVELOPMENT_LOG.md`](docs/DEVELOPMENT_LOG.md)：开发日志，每次重要改动后都要追加记录。
- [`docs/WORKFLOW.md`](docs/WORKFLOW.md)：开发协作规范，规定每次开发如何同步代码与文档。
- [`docs/AI_CONTEXT.md`](docs/AI_CONTEXT.md)：AI 协作上下文，用于在后续对话中快速恢复项目背景。
- [`docs/CONTENT_PIPELINE.md`](docs/CONTENT_PIPELINE.md)：资源、数据、命名和内容制作规范。

## 项目结构

```text
relicbound/
├── project.godot
├── README.md
├── .gitignore
├── docs/
│   ├── GAME_DESIGN.md
│   ├── TECHNICAL_DESIGN.md
│   ├── ROADMAP.md
│   ├── PROJECT_STATUS.md
│   ├── DEVELOPMENT_LOG.md
│   ├── WORKFLOW.md
│   ├── AI_CONTEXT.md
│   └── CONTENT_PIPELINE.md
├── scenes/
│   ├── player/
│   ├── enemies/
│   ├── levels/
│   ├── ui/
│   └── items/
├── scripts/
│   ├── player/
│   ├── enemies/
│   ├── combat/
│   ├── loot/
│   ├── inventory/
│   └── systems/
├── assets/
│   ├── sprites/
│   ├── audio/
│   ├── fonts/
│   └── effects/
└── data/
    ├── items/
    ├── enemies/
    └── relics/
```

## 开发原则

1. 先做可玩的最小闭环，再扩展复杂系统。
2. 每次新增功能，都要同步更新 `docs/PROJECT_STATUS.md` 和 `docs/DEVELOPMENT_LOG.md`。
3. 游戏逻辑尽量模块化，避免所有代码堆在玩家脚本里。
4. 数据尽量外置，装备、怪物、遗物等内容优先使用配置文件或 Godot Resource 管理。
5. 优先保证手感和反馈，再追求内容数量。

## 下一步

M0 完成后，进入 M1：角色基础控制原型。

M1 的目标：

- 创建玩家场景
- 实现左右移动、跳跃、重力、落地检测
- 添加摄像机跟随
- 创建测试关卡
- 建立基础输入映射
