# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest feedback and UI pass

- Added floating damage numbers when enemies and the boss take damage.
- Added boss grouping and a top-center boss HP panel for the ruin guardian.
- Added a result panel for victory and defeat states.
- Added player invulnerability frames after taking damage, with blinking feedback.
- Victory and defeat now both show a clear overlay and support R restart.
- Player fall death remains enabled for off-map recovery.

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
- Confirm damage numbers appear when hitting enemies.
- Confirm the boss HP panel appears and updates during the boss fight.
- Confirm player briefly blinks and ignores rapid repeated damage after being hit.
- Confirm victory shows a result panel and R restarts.
- Confirm defeat or fall death shows a result panel and R restarts.
- Confirm pickups still work.
- Check the Chinese HUD text and fixed player status panel.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
