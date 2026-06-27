# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest mine level prototype pass

- Added a playable second level prototype: `幽暗矿道`.
- Main menu now routes the second menu entry to `res://scenes/levels/mine_level.tscn` instead of the old placeholder.
- Added ranged enemy support with projectile shooting, spacing behavior, retreat behavior, and ranged loot drops.
- Added enemy projectile scene and script.
- Added spike trap scene and script; spikes damage the player when stepped on, respecting the player's existing invulnerability frames.
- Built the mine level with darker cave lighting, rock columns, platforms, common enemies, ranged enemies, spike traps, health pickups, and an exit portal objective.
- Existing main menu, level briefing overlay, improved portal visuals, richer loot drops, compact HUD, centered boss HP bar, player HP text inside the red HP bar, damage numbers, boss phase two, invulnerability frames, and R restart remain active.

## Collision layer plan

- World / ground: layer 1
- Player: layer 2
- Enemies / boss: layer 4
- Platforms: layer 8
- Enemy projectiles: layer 0, mask 3 for player/world detection
- Traps: layer 0, mask 2 for player detection

## Local test checklist

- Open the project with Godot 4.x.
- Run the main scene.
- Confirm the new main menu appears first.
- Confirm Start Trial enters the playable test level.
- Confirm Enter on the main menu quickly starts the test level.
- Confirm `幽暗矿道试玩` enters the mine level prototype.
- Confirm the mine level starts after pressing Enter on the level briefing.
- Check movement with A/D or arrow keys.
- Check jump with Space.
- Check attack with J or left mouse.
- Confirm ranged enemies keep distance and shoot projectiles.
- Confirm enemy projectiles damage the player and disappear on impact.
- Confirm spike traps damage the player without instantly melting HP due to invulnerability frames.
- Confirm clearing all mine enemies opens the improved purple portal near the end of the stage.
- Confirm touching the portal triggers victory.
- Confirm victory/defeat panel still shows gold and remaining HP.
- Confirm R restarts after victory, defeat, or fall death.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
