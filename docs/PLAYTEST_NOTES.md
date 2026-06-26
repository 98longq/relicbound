# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest HUD tuning pass

- Styled player and boss HP bars with red fills, dark backgrounds, borders, and rounded corners.
- Moved the player HP bar away from the center HUD area to a compact left-side position below the control/status panel.
- Kept the boss HP bar centered near the top as the main boss encounter indicator.
- Boss phase-two HUD name, damage numbers, invulnerability frames, result panels, and R restart remain active.

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
- Confirm player HP bar is red and positioned neatly on the left side.
- Confirm boss HP bar is red and updates during the boss fight.
- Confirm player HP bar updates when taking damage or healing.
- Confirm boss enters phase two at low health and the HUD name changes to `遗迹守卫·狂暴`.
- Confirm victory/defeat panel still shows gold and remaining HP.
- Confirm R restarts after victory, defeat, or fall death.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
