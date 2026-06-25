# Generated Art Assets

This folder is reserved for the first visual art pass of Relicbound.

## Planned files

Place the generated image files into these paths when they are available locally:

- `assets/generated/hero/hero_sheet.png`
- `assets/generated/enemies/enemy_sheet.png`
- `assets/generated/items/items_sheet.png`
- `assets/generated/environment/environment_sheet.png`

## Intended usage

### 1. Hero sheet

Target file:

- `assets/generated/hero/hero_sheet.png`

Purpose:

- Player character reference sheet.
- Idle, run, jump, light attack, hurt, death states.

### 2. Enemy sheet

Target file:

- `assets/generated/enemies/enemy_sheet.png`

Purpose:

- Common enemy references.
- Boss reference.
- Later can be split into separate animation strips.

### 3. Item sheet

Target file:

- `assets/generated/items/items_sheet.png`

Purpose:

- Weapon icons.
- Coin and potion icons.
- Equipment and loot references.

### 4. Environment sheet

Target file:

- `assets/generated/environment/environment_sheet.png`

Purpose:

- Environment visual reference.
- Tile, platform, prop and lighting reference.
- Later can be converted into modular tilesets and level art.

## Current limitation

The current GitHub connector can write text files directly, but it does not reliably upload binary image files in this workflow.

Because of that, this repository currently stores the integration plan, folder conventions, and the asset manifest first.

After the PNG files are copied into the paths above, the next step is:

1. Split sheets into usable sprites.
2. Replace placeholder ColorRect visuals.
3. Build a proper environment tileset.
4. Wire character and enemy art into animated scenes.
