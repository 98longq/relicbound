# Playtest Notes

Updated: 2026-06-25

## Current build

Playable Slice 001

## Latest combat tuning pass

- Shortened the player melee reach slightly again.
- Reduced common enemy and boss hurtbox volume a little so hits do not feel too generous.
- Increased common enemy attack range and stop distance so enemies start attacks during player kiting instead of only chasing.
- Increased boss attack range and stop distance so the boss starts attacking from a clearer distance.
- Kept enemy attack lunge/tint feedback visible.
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
- Confirm player melee reach is slightly shorter than the previous build.
- Confirm hits still connect around visible enemy body contact.
- Confirm common enemies begin attack motion more often when the player kites near them.
- Confirm the boss begins attack motion from a readable distance.
- Confirm falling below the level causes death and allows R restart.
- Confirm pickups still work.
- Check the Chinese HUD text and fixed player status panel.
- Check R restart.

## Next development rule

Future changes should be driven by local playtest feedback first. Fix runtime errors and feel issues before adding larger systems.
