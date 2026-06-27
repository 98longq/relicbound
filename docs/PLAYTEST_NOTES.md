# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest menu and portal polish pass

- Added a simple start menu overlay before the level begins.
- The game now pauses on the start menu and begins after pressing Enter.
- Improved the exit portal from a flat purple rectangle into a layered portal effect.
- The portal now has an oval glow, inner core, outer and inner rings, rune marks, floating light particles, and pulsing animation.
- The portal still opens only after all enemies are defeated and still triggers victory when the player enters it.
- Existing richer loot drops, compact HUD, centered boss HP bar, player HP text inside the red HP bar, damage numbers, boss phase two, invulnerability frames, and R restart remain active.

## Collision layer plan

- World / ground: layer 1
- Player: layer 2
- Enemies / boss: layer 4
- Platforms: layer 8

## Local test checklist

- Open the project with Godot 4.x.
- Run the main scene.
- Confirm the start menu appears and the game is paused before pressing Enter.
- Confirm pressing Enter starts the level.
- Check movement with A/D or arrow keys.
- Check jump with Space.
- Check attack with J or left mouse.
- Confirm normal enemies can drop gold and sometimes health.
- Confirm the boss drops large gold and health.
- Confirm clearing all enemies opens the improved purple portal near the end of the stage.
- Confirm the portal is no longer just a purple rectangle.
- Confirm touching the portal triggers victory.
- Confirm the objective text changes to the portal objective after all enemies are defeated.
- Confirm the boss HP panel remains centered at the top of the screen.
- Confirm player HP text is inside the red HP bar.
- Confirm victory/defeat panel still shows gold and remaining HP.
- Confirm R restarts after victory, defeat, or fall death.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
