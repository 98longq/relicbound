# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest tuning pass

- Shortened the player melee reach again so attacks feel closer to weapon contact.
- Kept enlarged enemy and boss hurtboxes so hits connect on visible body contact instead of requiring overlap.
- Added player fall death when falling below the stage, preventing the player from getting stuck off-map.
- Made enemy attack feedback more visible with a longer lunge, tint, squash, and small vertical motion.
- Enemy hit feedback still affects only the sprite, not the ColorRect container.

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
- Confirm melee reach is shorter but still hits on visible contact.
- Confirm enemies show a clear attack lunge/tint when attacking.
- Confirm falling off the right side or below the level causes death and allows R restart.
- Confirm common enemies and boss no longer flash a white rectangle when hit.
- Check pickups still work.
- Check the Chinese HUD text and fixed player status panel.
- Check R restart.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
