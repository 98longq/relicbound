# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest visual enrichment pass

- Added generated sheet background removal shader.
- Replaced the visible attack debug box with player attack pose switching.
- Added basic player sprite states for idle, run, jump, and attack.
- Applied sheet background cleanup to player, common enemy, boss, gold pickup, and health pickup visuals.
- Added a fixed HUD panel with objective, player HP, gold, and control hints.
- Added first-pass environment art overlays for the ground and platforms.

## Local test checklist

- Open the project with Godot 4.x.
- Run the main scene.
- Check movement with A/D or arrow keys.
- Check jump with Space.
- Check attack with J or left mouse.
- Confirm the yellow attack debug box is no longer visible.
- Confirm character state art changes while moving, jumping, and attacking.
- Check pickups.
- Check the Chinese HUD text and fixed player status panel.
- Check that generated sheet backgrounds are mostly removed from sprites.
- Check R restart.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
