# 项目状态：Relicbound

最后更新：2026-06-25

## 当前阶段

当前里程碑：**M1：角色基础控制原型**

当前状态：**M1 原型已提交，等待用户本地 Godot 运行验证**

## 项目基本信息

- 项目名：Relicbound
- 中文名：遗物之契
- 仓库：98longq/relicbound
- 引擎：Godot 4.x
- 语言：GDScript
- 类型：2D 横板动作刷宝 Roguelite
- 当前目标：验证玩家基础移动、跳跃、落地和摄像机跟随

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

## 正在进行

- [ ] 用户本地用 Godot 4.x 打开项目并运行主场景
- [ ] 验证移动手感是否合适
- [ ] 验证跳跃高度、重力和平台碰撞是否正常
- [ ] 验证摄像机跟随是否正常

## 下一步任务

M1 验证通过后，进入 M2：基础战斗闭环。

M2 首要任务：

1. 创建玩家攻击判定区域。
2. 创建基础敌人场景。
3. 创建敌人基础脚本。
4. 实现敌人血量、受击和死亡。
5. 在测试关卡中放置一个测试敌人。
6. 同步更新 `docs/PROJECT_STATUS.md` 和 `docs/DEVELOPMENT_LOG.md`。

## 当前阻塞点

暂无代码层面的阻塞。

需要用户本地确认的事项：

- 克隆仓库后是否能用 Godot 4.x 打开项目。
- 主场景是否能正常运行。
- 玩家是否能用 A/D 或方向键移动。
- 玩家是否能用 Space 跳跃。
- 摄像机是否跟随玩家。

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

2026-06-25：完成 M1 玩家基础控制原型。新增玩家控制脚本、玩家场景，并将测试关卡扩展为可运行平台测试场景。当前等待用户本地 Godot 运行验证，验证通过后进入 M2 基础战斗闭环。
