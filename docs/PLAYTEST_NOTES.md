# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest combat feel tuning pass

- Extended the player melee attack area forward and slightly upward.
- Increased the attack hitbox size from a close-range box to a wider sword-like reach.
- Tuned common enemy hurtbox size to better match the visible body.
- Tuned boss hurtbox size so attacks connect before the player visually overlaps the boss body.
- Changed enemy hit feedback to flash the sprite itself instead of flashing the invisible ColorRect container.
- Removed the white rectangular flash that appeared when enemies were hit.

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
- Confirm the player cannot push the boss or common enemies.
- Confirm the player can pass through enemy bodies.
- Check attack with J or left mouse.
- Confirm melee hits connect before the player overlaps the boss sprite.
- Confirm common enemies and boss no longer flash a white rectangle when hit.
- Check pickups still work.
- Check the Chinese HUD text and fixed player status panel.
- Check R restart.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
