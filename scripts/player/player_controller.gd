extends CharacterBody2D
class_name PlayerController

## M1 player movement prototype.
## This script intentionally focuses only on movement, jumping, facing, and camera-ready control.
## Combat, stats, inventory, and relic logic should stay outside this script in later milestones.

@export var move_speed: float = 260.0
@export var acceleration: float = 1800.0
@export var friction: float = 2200.0
@export var jump_velocity: float = -520.0
@export var gravity: float = 1600.0
@export var max_fall_speed: float = 900.0

@onready var visual: ColorRect = $Visual

var facing_direction: int = 1


func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_handle_horizontal_movement(delta)
	_handle_jump()
	move_and_slide()
	_update_facing_visual()


func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y = minf(velocity.y + gravity * delta, max_fall_speed)
	elif velocity.y > 0.0:
		velocity.y = 0.0


func _handle_horizontal_movement(delta: float) -> void:
	var direction := _get_move_axis()

	if not is_zero_approx(direction):
		velocity.x = move_toward(velocity.x, direction * move_speed, acceleration * delta)
		facing_direction = 1 if direction > 0.0 else -1
	else:
		velocity.x = move_toward(velocity.x, 0.0, friction * delta)


func _handle_jump() -> void:
	if _is_jump_pressed() and is_on_floor():
		velocity.y = jump_velocity


func _get_move_axis() -> float:
	# Prefer project-specific gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")

	# Keep fallback controls so the M1 prototype is immediately testable even before
	# the InputMap is edited in Godot's project settings.
	if is_zero_approx(direction):
		if Input.is_physical_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
			direction -= 1.0
		if Input.is_physical_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
			direction += 1.0

	# Godot's built-in UI actions are another useful fallback for keyboard/gamepad tests.
	if is_zero_approx(direction):
		direction = Input.get_axis("ui_left", "ui_right")

	return clampf(direction, -1.0, 1.0)


func _is_jump_pressed() -> bool:
	return (
		Input.is_action_just_pressed("jump")
		or Input.is_action_just_pressed("ui_accept")
		or Input.is_physical_key_pressed(KEY_SPACE)
	)


func _update_facing_visual() -> void:
	if visual == null:
		return

	# ColorRect does not flip like Sprite2D, so scale the visual around the player.
	# This gives us visible facing feedback while using placeholder graphics.
	visual.scale.x = float(facing_direction)
