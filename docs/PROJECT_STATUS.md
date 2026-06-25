# 项目状态：Relicbound

最后更新：2026-06-25

## 当前阶段

当前里程碑：**M0：项目规划与基础框架**

当前状态：**基本完成，等待本地 Godot 打开验证**

## 项目基本信息

- 项目名：Relicbound
- 中文名：遗物之契
- 仓库：98longq/relicbound
- 引擎：Godot 4.x
- 语言：GDScript
- 类型：2D 横板动作刷宝 Roguelite
- 当前目标：建立长期可持续开发的文档体系和基础工程结构

## 已完成

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
- [x] 补齐场景目录：`scenes/player/`、`scenes/enemies/`、`scenes/levels/`、`scenes/ui/`、`scenes/items/`
- [x] 补齐脚本目录：`scripts/player/`、`scripts/enemies/`、`scripts/combat/`、`scripts/loot/`、`scripts/inventory/`、`scripts/systems/`
- [x] 补齐资源目录：`assets/sprites/`、`assets/audio/`、`assets/fonts/`、`assets/effects/`
- [x] 补齐数据目录：`data/items/`、`data/enemies/`、`data/relics/`

## 正在进行

- [ ] 本地打开 Godot 4 项目进行验证
- [ ] 开始 M1：玩家基础控制原型

## 下一步任务

M1 首要任务：

1. 用 Godot 4.x 克隆并打开项目，确认 `project.godot` 可识别。
2. 检查 `scenes/levels/test_level.tscn` 是否可作为主场景打开。
3. 创建 `scenes/player/player.tscn`。
4. 创建 `scripts/player/player_controller.gd`。
5. 实现玩家左右移动、跳跃、重力、落地检测。
6. 添加摄像机跟随。
7. 同步更新 `docs/PROJECT_STATUS.md` 和 `docs/DEVELOPMENT_LOG.md`。

## 当前阻塞点

暂无代码层面的阻塞。

需要用户本地确认的事项：

- 本地是否安装 Godot 4.x。
- 克隆仓库后是否能打开项目。
- 如果 Godot 版本不是 4.3，后续可调整 `project.godot` 的 features 配置。

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

2026-06-25：完成项目文档体系与基础框架初始化。仓库已包含 README、Godot 工程入口、核心设计文档、技术文档、路线图、项目状态、开发日志、AI 协作上下文、内容制作规范、基础目录结构、占位图标和测试关卡占位场景。下一步进入 M1 玩家基础控制原型。
