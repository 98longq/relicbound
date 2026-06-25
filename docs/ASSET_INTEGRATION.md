# Asset Integration Plan

Updated: 2026-06-25

## Goal

Integrate the first generated image elements into the Relicbound project in a structured way.

This pass focuses on:

1. Defining where the generated art belongs.
2. Recording which gameplay systems should use which art sheet.
3. Preparing the repository for a later art-to-scene replacement pass.

## Generated asset set

### Hero sheet

Source label:

- `战士像素动画表`

Target repository path:

- `assets/generated/hero/hero_sheet.png`

Planned use:

- Replace the player placeholder block.
- Build animation states for idle, run, jump, attack, hurt, death.

## Enemy sheet

Source label:

- `怪物角色设计图表`

Target repository path:

- `assets/generated/enemies/enemy_sheet.png`

Planned use:

- Create a crawler enemy variant.
- Create a skeletal warrior enemy variant.
- Upgrade the current boss presentation using the ruin guardian concept.

## Item sheet

Source label:

- `复古像素rpg物品一览`

Target repository path:

- `assets/generated/items/items_sheet.png`

Planned use:

- Replace pickup placeholders for gold and health.
- Provide future equipment icons.
- Provide future loot icons for inventory and UI.

## Environment sheet

Source label:

- `遗迹之境游戏场景素材设计`

Target repository path:

- `assets/generated/environment/environment_sheet.png`

Planned use:

- Replace simple block platforms.
- Guide the first environment tileset.
- Guide prop placement, torches, ruins, and background style.

## Current repository additions from this pass

- Added `assets/generated/README.md`
- Added `data/generated_assets.json`
- Added this document: `docs/ASSET_INTEGRATION.md`

## Why the PNG files are not yet committed directly

The current connector workflow can reliably write text files to GitHub, but it does not reliably upload binary image files in this session.

So this pass adds:

- folder conventions
- a machine-readable manifest
- a written integration plan

This keeps the project organized and makes the next art pass deterministic.

## Next implementation pass

After the PNG sheets are copied into the target paths, the next pass should do the following:

1. Create player animation resources.
2. Replace enemy placeholder visuals with sprites.
3. Replace item placeholder visuals with icons.
4. Create a basic environment art pass for the test level.
5. Update project documentation after art integration is complete.
