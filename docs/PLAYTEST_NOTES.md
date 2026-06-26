# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest collision correction pass

- Corrected player collision settings to `layer 2` and `mask 9`.
- Corrected common enemy and boss collision settings to `layer 4` and `mask 1`.
- Corrected the player attack area to detect enemy `layer 4`.
- Confirmed pickups are configured to detect player `layer 2`.
- Confirmed platforms use `layer 8`, while the player mask includes that layer.

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
- Confirm each platform can be reached and stood on.
- Confirm the boss no longer gets stuck under platforms.
- Confirm the player cannot push the boss or common enemies.
- Confirm the player can pass through enemy bodies.
- Check attack with J or left mouse.
- Check pickups still work after the collision layer change.
- Check the Chinese HUD text and fixed player status panel.
- Check R restart.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
