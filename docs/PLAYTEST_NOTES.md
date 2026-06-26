# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest progression and loot pass

- Changed the win flow from instant victory after clearing enemies to an exit portal flow.
- After all enemies are defeated, a purple exit portal opens near the end of the stage.
- Entering the opened portal triggers victory and the existing result panel.
- Added a large gold pickup worth 10 gold.
- Common enemies still drop normal gold and now have a chance to drop a health pickup.
- The boss now drops large gold and a health pickup when defeated.
- Compact HUD, centered boss HP bar, player HP text inside the red HP bar, damage numbers, boss phase two, invulnerability frames, and R restart remain active.

## Collision layer plan

- World / ground: layer 1
- Player: layer 2
- Enemies / boss: layer 4
- Platforms: layer 8

## Local test checklist

- Open the project with Godot 4.x.
- Run the main scene.
- Check movement with A/D or arrow keys.
- Check jump with Space.
- Check attack with J or left mouse.
- Confirm normal enemies can drop gold and sometimes health.
- Confirm the boss drops large gold and health.
- Confirm clearing all enemies opens the purple exit portal near the end of the stage.
- Confirm touching the portal triggers victory.
- Confirm the objective text changes to the portal objective after all enemies are defeated.
- Confirm the boss HP panel remains centered at the top of the screen.
- Confirm player HP text is inside the red HP bar.
- Confirm victory/defeat panel still shows gold and remaining HP.
- Confirm R restarts after victory, defeat, or fall death.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
