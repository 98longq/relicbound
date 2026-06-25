# 项目状态：Relicbound

最后更新：2026-06-25

## 当前阶段

当前里程碑：**M2：基础战斗闭环**

当前状态：**M2 最小战斗原型已提交，等待用户本地 Godot 运行验证**

## 项目基本信息

- 项目名：Relicbound
- 中文名：遗物之契
- 仓库：98longq/relicbound
- 引擎：Godot 4.x
- 语言：GDScript
- 类型：2D 横板动作刷宝 Roguelite
- 当前目标：验证玩家攻击、敌人受击掉血、敌人死亡消失

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

## 正在进行

- [ ] 用户本地用 Godot 4.x 打开项目并运行主场景
- [ ] 验证玩家移动、跳跃、平台碰撞和摄像机跟随是否正常
- [ ] 验证 J 或鼠标左键攻击是否正常
- [ ] 验证敌人是否掉血、闪白、死亡消失

## 下一步任务

M2 验证通过后，进入 M3：敌人 AI 与掉落系统。

M3 首要任务：

1. 让测试敌人能简单追踪玩家。
2. 实现敌人攻击玩家。
3. 实现玩家生命值和死亡状态。
4. 创建掉落物场景。
5. 实现金币或血瓶掉落。
6. 同步更新 `docs/PROJECT_STATUS.md` 和 `docs/DEVELOPMENT_LOG.md`。

## 当前阻塞点

暂无代码层面的阻塞。

需要用户本地确认的事项：

- 克隆仓库后是否能用 Godot 4.x 打开项目。
- 主场景是否能正常运行。
- 玩家是否能用 A/D 或方向键移动。
- 玩家是否能用 Space 跳跃。
- 玩家是否能用 J 或鼠标左键攻击。
- 攻击测试敌人后，敌人血量是否下降。
- 多次攻击后，敌人是否死亡消失。

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

2026-06-25：完成 M2 最小战斗原型。玩家拥有短暂近战攻击判定，测试敌人拥有血量、受击反馈和死亡逻辑，测试关卡已放置可攻击敌人。当前等待用户本地 Godot 运行验证，验证通过后进入 M3 敌人 AI 与掉落系统。
