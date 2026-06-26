# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest tuning pass

- Replaced horizontally stretched environment art with repeated tile sprites to reduce ground blur.
- Increased player jump height so platforms are reachable.
- Adjusted platform positions for better reachability.
- Changed player and enemy collision layers so the player can pass through enemy bodies.
- Kept attack detection on enemy bodies through the player AttackArea collision mask.

## Local test checklist

- Open the project with Godot 4.x.
- Run the main scene.
- Check movement with A/D or arrow keys.
- Check jump with Space.
- Confirm each platform can be reached.
- Confirm the boss no longer physically blocks player movement.
- Check attack with J or left mouse.
- Check pickups.
- Check the Chinese HUD text and fixed player status panel.
- Check that ground and platform art is less blurry than before.
- Check R restart.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
