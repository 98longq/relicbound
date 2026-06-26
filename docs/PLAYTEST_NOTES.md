# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest enrichment pass

- Slightly shortened the player melee reach while keeping the attack area forward and readable.
- Increased common enemy and boss hurtbox volume so hits feel like they connect on visible body contact.
- Added enemy attack motion feedback: enemies now briefly lunge and tint when they attack.
- Expanded the test level to a longer stage with more ground, more platform sections, two additional common enemies, and one extra health pickup.
- Moved the boss farther to the right so the level has a clearer end encounter.
- Extended the player camera right limit to support the longer map.

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
- Check attack with J or left mouse.
- Confirm melee hits feel like they connect on visible enemy contact.
- Confirm common enemies and boss no longer flash a white rectangle when hit.
- Confirm enemies show a visible attack lunge when attacking.
- Confirm the longer map scrolls correctly to the right.
- Check pickups still work.
- Check the Chinese HUD text and fixed player status panel.
- Check R restart.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
