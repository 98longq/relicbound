# 项目状态：Relicbound

最后更新：2026-06-25

## 当前阶段

当前里程碑：**M0：项目规划与基础框架**

当前状态：**进行中**

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
- [x] 添加游戏设计文档
- [x] 添加技术设计文档
- [x] 添加开发路线图
- [x] 添加项目状态文档

## 正在进行

- [ ] 补齐基础目录结构
- [ ] 补齐开发流程文档
- [ ] 补齐 AI 协作上下文
- [ ] 补齐内容制作规范

## 下一步任务

进入 M1 前需要完成：

1. 确认仓库目录结构完整。
2. 用 Godot 4 打开项目，确认 `project.godot` 可识别。
3. 如果 Godot 提示缺少主场景，下一步创建 `scenes/levels/test_level.tscn`。
4. 开始 M1：玩家基础控制原型。

## 当前阻塞点

暂无代码层面的阻塞。

需要用户本地确认的事项：

- 本地是否安装 Godot 4.x。
- 克隆仓库后是否能打开项目。

## 开发同步规则

每次开发结束后，必须同步更新：

1. `docs/PROJECT_STATUS.md`：更新当前状态、已完成、下一步、阻塞点。
2. `docs/DEVELOPMENT_LOG.md`：追加本次变更记录。
3. 必要时更新：
   - `docs/GAME_DESIGN.md`
   - `docs/TECHNICAL_DESIGN.md`
   - `docs/ROADMAP.md`
   - `README.md`

## 最近一次更新摘要

2026-06-25：完成项目初始化规划，创建 README、Godot 基础工程文件和核心文档体系。
