# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest gameplay progression pass

- Added a boss phase-two enraged state at low health.
- In phase two, the boss becomes faster, hits harder, attacks more often, and has stronger lunge feedback.
- Boss HUD now changes the boss name to `遗迹守卫·狂暴` during phase two.
- Added a dynamic player HP bar to the HUD in addition to the existing text status.
- Victory and defeat result panels now include collected gold and remaining HP.
- Existing damage numbers, player invulnerability frames, boss HP panel, and R restart remain active.

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
- Confirm the player HP bar updates when taking damage or healing.
- Confirm damage numbers appear when hitting enemies.
- Confirm boss HP panel updates during the boss fight.
- Confirm boss enters phase two at low health and the HUD name changes to `遗迹守卫·狂暴`.
- Confirm phase-two boss attacks feel more dangerous but still readable.
- Confirm victory/defeat panel shows gold and remaining HP.
- Confirm R restarts after victory, defeat, or fall death.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
