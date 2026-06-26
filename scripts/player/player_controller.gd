extends CharacterBody2D
class_name PlayerController

## Player prototype controller.
## Handles movement, jumping, facing, light attack, health, death, pickups, and basic sprite state switching.

@export_group("Movement")
@export var move_speed: float = 260.0
@export var acceleration: float = 1800.0
@export var friction: float = 2200.0
@export var jump_velocity: float = -760.0
@export var gravity: float = 1700.0
@export var max_fall_speed: float = 950.0

@export_group("Combat")
@export var attack_damage: int = 10
@export var attack_cooldown: float = 0.35
@export var attack_active_time: float = 0.18
@export var attack_offset_x: float = 72.0
@export var attack_offset_y: float = -34.0

@export_group("Stats")
@export var max_health: int = 100

@export_group("Art")
@export var idle_texture: Texture2D
@export var run_texture: Texture2D
@export var jump_texture: Texture2D
@export var attack_texture: Texture2D

@onready var visual: ColorRect = $Visual
@onready var art_sprite: Sprite2D = $Visual/Art
@onready var attack_area: Area2D = $AttackArea
@onready var attack_visual: ColorRect = $AttackArea/AttackVisual
@onready var status_label: Label = $StatusLabel

var current_health: int
var gold: int = 0
var facing_direction: int = 1
var is_dead: bool = false

var _attack_cooldown_timer: float = 0.0
var _attack_active_timer: float = 0.0
var _hit_targets: Array[Node] = []
var _base_art_modulate: Color = Color.WHITE
var _hurt_flash_timer: float = 0.0


func _ready() -> void:
	current_health = max_health
	add_to_group("player")
	_set_attack_active(false)

	if visual != null:
		visual.color = Color(1.0, 1.0, 1.0, 0.0)

	if art_sprite != null:
		_base_art_modulate = art_sprite.modulate
		_set_art_texture(idle_texture)

	_update_status_label()


func _physics_process(delta: float) -> void:
	_update_hurt_flash(delta)

	if is_dead:
		_handle_dead_restart_input()
		return

	_update_attack_timers(delta)
	_apply_gravity(delta)
	_handle_horizontal_movement(delta)
	_handle_jump()
	_handle_attack_input()
	move_and_slide()
	_update_facing_visual()
	_update_attack_area_position()
	_update_art_state()


func apply_damage(amount: int, source: Node = null) -> void:
	if is_dead:
		return

	current_health = maxi(current_health - amount, 0)
	_start_hurt_feedback()
	_update_status_label()

	if current_health <= 0:
		die(source)


func collect_pickup(pickup_type: String, amount: int) -> void:
	match pickup_type:
		"gold":
			gold += amount
		"health":
			current_health = mini(current_health + amount, max_health)
		_:
			pass

	_update_status_label()


func die(source: Node = null) -> void:
	if is_dead:
		return

	is_dead = true
	velocity = Vector2.ZERO
	_set_attack_active(false)

	if art_sprite != null:
		art_sprite.modulate = Color(0.35, 0.35, 0.35, 1.0)

	_update_status_label()


func _handle_dead_restart_input() -> void:
	if Input.is_physical_key_pressed(KEY_R):
		get_tree().reload_current_scene()


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
	_set_art_texture(attack_texture)
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
		if body == self:
			continue
		if not body.is_in_group("enemies"):
			continue
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
		attack_visual.visible = false


func _update_attack_area_position() -> void:
	if attack_area == null:
		return

	attack_area.position.x = attack_offset_x * float(facing_direction)
	attack_area.position.y = attack_offset_y


func _start_hurt_feedback() -> void:
	_hurt_flash_timer = 0.08
	if art_sprite != null:
		art_sprite.modulate = Color(1.0, 0.55, 0.55, 1.0)


func _update_hurt_flash(delta: float) -> void:
	if _hurt_flash_timer <= 0.0:
		return

	_hurt_flash_timer -= delta
	if _hurt_flash_timer <= 0.0 and art_sprite != null and not is_dead:
		art_sprite.modulate = _base_art_modulate


func _update_status_label() -> void:
	if status_label == null:
		return

	var state_text := ""
	if is_dead:
		state_text = " | 已死亡 - 按 R 重开"

	status_label.text = "生命: %s/%s | 金币: %s%s" % [current_health, max_health, gold, state_text]


func _get_move_axis() -> float:
	var direction := Input.get_axis("move_left", "move_right")

	if is_zero_approx(direction):
		if Input.is_physical_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
			direction -= 1.0
		if Input.is_physical_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
			direction += 1.0

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

	visual.scale.x = float(facing_direction)


func _update_art_state() -> void:
	if _attack_active_timer > 0.0:
		_set_art_texture(attack_texture)
		return

	if not is_on_floor():
		_set_art_texture(jump_texture)
		return

	if absf(velocity.x) > 20.0:
		_set_art_texture(run_texture)
		return

	_set_art_texture(idle_texture)


func _set_art_texture(texture: Texture2D) -> void:
	if art_sprite == null or texture == null:
		return

	if art_sprite.texture != texture:
		art_sprite.texture = texture
