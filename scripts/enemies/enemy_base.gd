extends CharacterBody2D
class_name EnemyBase

## Enemy prototype.
## Covers health, receiving damage, gravity, hit feedback, death, simple chasing,
## contact-range attacks, visible attack feedback, damage numbers, boss phase changes, and varied loot drops.

const DAMAGE_NUMBER_SCENE := preload("res://scenes/ui/damage_number.tscn")

@export_group("Stats")
@export var max_health: int = 30
@export var gravity: float = 1600.0
@export var max_fall_speed: float = 900.0
@export var is_boss: bool = false

@export_group("AI")
@export var move_speed: float = 90.0
@export var detection_range: float = 420.0
@export var attack_range: float = 46.0
@export var stop_distance: float = 34.0

@export_group("Combat")
@export var attack_damage: int = 8
@export var attack_cooldown: float = 0.9
@export var hit_flash_time: float = 0.08
@export var attack_feedback_time: float = 0.32
@export var attack_lunge_distance: float = 28.0
@export var attack_squash_scale: Vector2 = Vector2(1.28, 0.84)

@export_group("Boss Phase")
@export_range(0.05, 0.95, 0.05) var phase_two_health_ratio: float = 0.5
@export var phase_two_move_multiplier: float = 1.25
@export var phase_two_damage_bonus: int = 4
@export var phase_two_attack_cooldown_multiplier: float = 0.78
@export var phase_two_lunge_multiplier: float = 1.35

@export_group("Loot")
@export var loot_scene: PackedScene
@export_range(0.0, 1.0, 0.05) var loot_drop_chance: float = 1.0
@export var bonus_loot_scene: PackedScene
@export_range(0.0, 1.0, 0.05) var bonus_loot_drop_chance: float = 0.0

@onready var visual: ColorRect = $Visual
@onready var art_sprite: Sprite2D = get_node_or_null("Visual/Art") as Sprite2D
@onready var health_label: Label = $HealthLabel

var current_health: int
var is_dead: bool = false
var facing_direction: int = -1
var is_phase_two: bool = false

var _target: Node2D
var _attack_cooldown_timer: float = 0.0
var _hit_flash_timer: float = 0.0
var _attack_feedback_timer: float = 0.0
var _base_art_modulate: Color = Color.WHITE
var _base_art_position: Vector2 = Vector2.ZERO
var _base_art_scale: Vector2 = Vector2.ONE


func _ready() -> void:
	current_health = max_health
	add_to_group("enemies")
	if is_boss:
		add_to_group("bosses")

	# Visual is kept as an invisible container. Hit feedback should affect only
	# the sprite, otherwise a white rectangle flashes around the enemy.
	if visual != null:
		visual.color = Color(1.0, 1.0, 1.0, 0.0)

	if art_sprite != null:
		_base_art_modulate = art_sprite.modulate
		_base_art_position = art_sprite.position
		_base_art_scale = art_sprite.scale

	_update_health_label()


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	_attack_cooldown_timer = maxf(_attack_cooldown_timer - delta, 0.0)

	_apply_gravity(delta)
	_update_hit_flash(delta)
	_update_attack_feedback(delta)
	_update_target()
	_update_ai(delta)
	move_and_slide()
	_update_facing_visual()


func apply_damage(amount: int, source: Node = null) -> void:
	if is_dead:
		return

	current_health = maxi(current_health - amount, 0)
	_spawn_damage_number(amount)
	_try_enter_phase_two()
	_start_hit_feedback()
	_update_health_label()

	if current_health <= 0:
		die(source)


func die(source: Node = null) -> void:
	if is_dead:
		return

	is_dead = true
	_drop_loot()
	queue_free()


func _update_target() -> void:
	if _target != null and is_instance_valid(_target):
		return

	var players := get_tree().get_nodes_in_group("player")
	if players.is_empty():
		_target = null
		return

	_target = players[0] as Node2D


func _update_ai(delta: float) -> void:
	if _target == null or not is_instance_valid(_target):
		velocity.x = move_toward(velocity.x, 0.0, move_speed * 8.0 * delta)
		return

	var to_target := _target.global_position - global_position
	var horizontal_distance := absf(to_target.x)
	var vertical_distance := absf(to_target.y)

	if horizontal_distance > detection_range or vertical_distance > 120.0:
		velocity.x = move_toward(velocity.x, 0.0, move_speed * 8.0 * delta)
		return

	if horizontal_distance > stop_distance:
		var direction := 1.0 if to_target.x > 0.0 else -1.0
		velocity.x = direction * move_speed
		facing_direction = 1 if direction > 0.0 else -1
	else:
		velocity.x = 0.0

	if horizontal_distance <= attack_range and vertical_distance <= 72.0:
		_try_attack_target()


func _try_attack_target() -> void:
	if _attack_cooldown_timer > 0.0:
		return

	if _target == null or not is_instance_valid(_target):
		return

	_start_attack_feedback()

	if _target.has_method("apply_damage"):
		_target.apply_damage(attack_damage, self)
		_attack_cooldown_timer = attack_cooldown


func _try_enter_phase_two() -> void:
	if not is_boss or is_phase_two:
		return

	if current_health <= 0:
		return

	var health_ratio := float(current_health) / float(max_health)
	if health_ratio > phase_two_health_ratio:
		return

	is_phase_two = true
	move_speed *= phase_two_move_multiplier
	attack_damage += phase_two_damage_bonus
	attack_cooldown = maxf(0.45, attack_cooldown * phase_two_attack_cooldown_multiplier)
	attack_lunge_distance *= phase_two_lunge_multiplier
	_base_art_modulate = Color(1.0, 0.62, 0.62, 1.0)
	_hit_flash_timer = maxf(_hit_flash_timer, 0.28)
	if art_sprite != null:
		art_sprite.modulate = Color(1.0, 0.32, 0.32, 1.0)


func _drop_loot() -> void:
	_spawn_loot_scene(loot_scene, loot_drop_chance, Vector2(0, -18))
	_spawn_loot_scene(bonus_loot_scene, bonus_loot_drop_chance, Vector2(28, -18))


func _spawn_loot_scene(scene: PackedScene, chance: float, offset: Vector2) -> void:
	if scene == null:
		return

	if randf() > chance:
		return

	var loot := scene.instantiate()
	if loot == null:
		return

	get_parent().add_child(loot)
	loot.global_position = global_position + offset


func _spawn_damage_number(amount: int) -> void:
	var damage_number := DAMAGE_NUMBER_SCENE.instantiate()
	if damage_number == null:
		return

	var parent := get_parent()
	if parent == null:
		return

	parent.add_child(damage_number)
	var height_offset := -96.0 if is_boss else -52.0
	damage_number.global_position = global_position + Vector2(randf_range(-18.0, 18.0), height_offset)
	if damage_number.has_method("setup"):
		damage_number.setup(amount, is_boss)


func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y = minf(velocity.y + gravity * delta, max_fall_speed)
	elif velocity.y > 0.0:
		velocity.y = 0.0


func _start_hit_feedback() -> void:
	_hit_flash_timer = hit_flash_time
	if art_sprite != null:
		art_sprite.modulate = Color(1.0, 0.55, 0.55, 1.0)


func _update_hit_flash(delta: float) -> void:
	if _hit_flash_timer <= 0.0:
		return

	_hit_flash_timer -= delta
	if _hit_flash_timer <= 0.0 and art_sprite != null and _attack_feedback_timer <= 0.0:
		art_sprite.modulate = _base_art_modulate


func _start_attack_feedback() -> void:
	_attack_feedback_timer = attack_feedback_time
	if art_sprite != null:
		art_sprite.modulate = Color(1.0, 0.75, 0.32, 1.0)
		art_sprite.scale = _base_art_scale * attack_squash_scale


func _update_attack_feedback(delta: float) -> void:
	if art_sprite == null:
		return

	if _attack_feedback_timer <= 0.0:
		art_sprite.position = _base_art_position
		art_sprite.scale = _base_art_scale
		return

	_attack_feedback_timer -= delta
	var progress := 1.0 - clampf(_attack_feedback_timer / attack_feedback_time, 0.0, 1.0)
	var lunge_factor := sin(progress * PI)
	art_sprite.position = _base_art_position + Vector2(attack_lunge_distance * lunge_factor, -4.0 * lunge_factor)
	art_sprite.scale = _base_art_scale.lerp(_base_art_scale * attack_squash_scale, lunge_factor)

	if _attack_feedback_timer <= 0.0:
		art_sprite.position = _base_art_position
		art_sprite.scale = _base_art_scale
		if _hit_flash_timer <= 0.0:
			art_sprite.modulate = _base_art_modulate


func _update_facing_visual() -> void:
	if visual == null:
		return

	visual.scale.x = float(facing_direction)


func _update_health_label() -> void:
	if health_label == null:
		return

	if is_boss and is_phase_two:
		health_label.text = "BOSS 2 %s/%s" % [current_health, max_health]
	else:
		health_label.text = "%s/%s" % [current_health, max_health]
