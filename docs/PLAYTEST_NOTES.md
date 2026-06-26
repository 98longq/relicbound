# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest collision tuning pass

- Separated collision layers into world, player, enemy, and platform groups.
- Player now collides with ground and platforms only.
- Enemies and boss now collide with ground only, so they do not get stuck under platforms.
- Player attacks still detect enemies through the AttackArea enemy mask.
- Pickups now detect the player layer directly.
- Platform art remains tiled instead of stretched.

## Local test checklist

- Open the project with Godot 4.x.
- Run the main scene.
- Check movement with A/D or arrow keys.
- Check jump with Space.
- Confirm each platform can be reached.
- Confirm the boss no longer gets stuck under platforms.
- Confirm the player cannot push the boss or common enemies.
- Confirm the player can pass through enemy bodies.
- Check attack with J or left mouse.
- Check pickups still work after the collision layer change.
- Check the Chinese HUD text and fixed player status panel.
- Check R restart.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
