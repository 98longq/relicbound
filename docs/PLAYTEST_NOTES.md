# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest main menu and level flow pass

- Added a dedicated main menu scene as the project startup scene.
- Main menu includes Start Trial, Next Level Preview, and Quit buttons.
- Enter on the main menu quickly starts the playable test level.
- Added a next-level placeholder scene named `下一关：幽暗矿道`.
- The placeholder scene documents the intended next content direction: new terrain, new enemies, traps, and relic choice flow.
- Existing level briefing overlay, improved portal visuals, richer loot drops, compact HUD, centered boss HP bar, player HP text inside the red HP bar, damage numbers, boss phase two, invulnerability frames, and R restart remain active.

## Collision layer plan

- World / ground: layer 1
- Player: layer 2
- Enemies / boss: layer 4
- Platforms: layer 8

## Local test checklist

- Open the project with Godot 4.x.
- Run the main scene.
- Confirm the new main menu appears first.
- Confirm Start Trial enters the playable test level.
- Confirm Enter on the main menu quickly starts the test level.
- Confirm Next Level Preview opens the placeholder scene.
- Confirm R or Esc returns from the placeholder scene to the main menu.
- Confirm the test level still shows the level briefing and starts after pressing Enter.
- Check movement with A/D or arrow keys.
- Check jump with Space.
- Check attack with J or left mouse.
- Confirm clearing all enemies opens the improved purple portal near the end of the stage.
- Confirm touching the portal triggers victory.
- Confirm victory/defeat panel still shows gold and remaining HP.
- Confirm R restarts after victory, defeat, or fall death.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
