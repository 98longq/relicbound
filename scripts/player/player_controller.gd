extends CharacterBody2D
class_name PlayerController

## M1/M2 player prototype.
## This script covers movement, jumping, facing, camera-ready control, and a minimal melee attack.
## Stats, inventory, relic logic, combo chains, and skill systems should stay outside this script later.

@export var move_speed: float = 260.0
@export var acceleration: float = 1800.0
@export var friction: float = 2200.0
@export var jump_velocity: float = -520.0
@export var gravity: float = 1600.0
@export var max_fall_speed: float = 900.0

@export_group("Combat")
@export var attack_damage: int = 10
@export var attack_cooldown: float = 0.35
@export var attack_active_time: float = 0.12

@onready var visual: ColorRect = $Visual
@onready var attack_area: Area2D = $AttackArea
@onready var attack_visual: ColorRect = $AttackArea/AttackVisual

var facing_direction: int = 1
var _attack_cooldown_timer: float = 0.0
var _attack_active_timer: float = 0.0
var _hit_targets: Array[Node] = []


func _ready() -> void:
	_set_attack_active(false)


func _physics_process(delta: float) -> void:
	_update_attack_timers(delta)
	_apply_gravity(delta)
	_handle_horizontal_movement(delta)
	_handle_jump()
	_handle_attack_input()
	move_and_slide()
	_update_facing_visual()
	_update_attack_area_position()


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


func _handle_attack_input() -> void:
	if _is_attack_pressed() and _attack_cooldown_timer <= 0.0:
		_start_attack()


func _start_attack() -> void:
	_attack_cooldown_timer = attack_cooldown
	_attack_active_timer = attack_active_time
	_hit_targets.clear()
	_set_attack_active(true)
	_apply_attack_hits()


func _update_attack_timers(delta: float) -> void:
	if _attack_cooldown_timer > 0.0:
		_attack_cooldown_timer -= delta

	if _attack_active_timer > 0.0:
		_attack_active_timer -= delta
		_apply_attack_hits()

		if _attack_active_timer <= 0.0:
			_set_attack_active(false)


func _apply_attack_hits() -> void:
	if attack_area == null:
		return

	for body in attack_area.get_overlapping_bodies():
		if body in _hit_targets:
			continue

		if body.has_method("apply_damage"):
			body.apply_damage(attack_damage, self)
			_hit_targets.append(body)


func _set_attack_active(is_active: bool) -> void:
	if attack_area != null:
		attack_area.monitoring = is_active
		attack_area.monitorable = false

	if attack_visual != null:
		attack_visual.visible = is_active


func _update_attack_area_position() -> void:
	if attack_area == null:
		return

	attack_area.position.x = 34.0 * float(facing_direction)


func _get_move_axis() -> float:
	# Prefer project-specific gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")

	# Keep fallback controls so the prototype is immediately testable even before
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


func _is_attack_pressed() -> bool:
	return (
		Input.is_action_just_pressed("attack")
		or Input.is_physical_key_pressed(KEY_J)
		or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	)


func _update_facing_visual() -> void:
	if visual == null:
		return

	# ColorRect does not flip like Sprite2D, so scale the visual around the player.
	# This gives us visible facing feedback while using placeholder graphics.
	visual.scale.x = float(facing_direction)
