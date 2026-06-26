# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest compact HUD tuning pass

- Recentered the boss HP panel and bar using the active viewport width instead of fixed left-biased coordinates.
- Kept player and boss HP bars styled with red fills, dark backgrounds, borders, and rounded corners.
- Moved the player HP text into the player HP bar itself.
- Merged gold display into the first objective line so the HUD uses fewer separate text rows.
- Left the controls hint below the compact player HP bar.
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
- Confirm the boss HP panel is centered at the top of the screen.
- Confirm player HP text is inside the red HP bar.
- Confirm gold is shown in the first objective line.
- Confirm player HP bar updates when taking damage or healing.
- Confirm boss HP bar updates during the boss fight.
- Confirm boss enters phase two at low health and the HUD name changes to `遗迹守卫·狂暴`.
- Confirm victory/defeat panel still shows gold and remaining HP.
- Confirm R restarts after victory, defeat, or fall death.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
