extends CharacterBody2D
class_name EnemyBase

## M3 enemy prototype.
## Covers health, receiving damage, basic gravity, hit feedback, death, simple chasing,
## simple contact-range attacks, and one loot drop scene.
## Advanced AI, navigation, elite modifiers, and loot tables belong to later milestones.

@export_group("Stats")
@export var max_health: int = 30
@export var gravity: float = 1600.0
@export var max_fall_speed: float = 900.0

@export_group("AI")
@export var move_speed: float = 90.0
@export var detection_range: float = 420.0
@export var attack_range: float = 46.0
@export var stop_distance: float = 34.0

@export_group("Combat")
@export var attack_damage: int = 8
@export var attack_cooldown: float = 0.75
@export var hit_flash_time: float = 0.08

@export_group("Loot")
@export var loot_scene: PackedScene
@export_range(0.0, 1.0, 0.05) var loot_drop_chance: float = 1.0

@onready var visual: ColorRect = $Visual
@onready var health_label: Label = $HealthLabel

var current_health: int
var is_dead: bool = false
var facing_direction: int = -1

var _target: Node2D
var _attack_cooldown_timer: float = 0.0
var _hit_flash_timer: float = 0.0
var _base_color: Color = Color(0.7, 0.18, 0.22, 1.0)


func _ready() -> void:
	current_health = max_health
	add_to_group("enemies")

	if visual != null:
		_base_color = visual.color

	_update_health_label()


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	_attack_cooldown_timer = maxf(_attack_cooldown_timer - delta, 0.0)

	_apply_gravity(delta)
	_update_hit_flash(delta)
	_update_target()
	_update_ai(delta)
	move_and_slide()
	_update_facing_visual()


func apply_damage(amount: int, source: Node = null) -> void:
	if is_dead:
		return

	current_health = maxi(current_health - amount, 0)
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

	if _target.has_method("apply_damage"):
		_target.apply_damage(attack_damage, self)
		_attack_cooldown_timer = attack_cooldown


func _drop_loot() -> void:
	if loot_scene == null:
		return

	if randf() > loot_drop_chance:
		return

	var loot := loot_scene.instantiate()
	if loot == null:
		return

	get_parent().add_child(loot)
	loot.global_position = global_position + Vector2(0, -18)


func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y = minf(velocity.y + gravity * delta, max_fall_speed)
	elif velocity.y > 0.0:
		velocity.y = 0.0


func _start_hit_feedback() -> void:
	_hit_flash_timer = hit_flash_time
	if visual != null:
		visual.color = Color(1.0, 1.0, 1.0, 1.0)


func _update_hit_flash(delta: float) -> void:
	if _hit_flash_timer <= 0.0:
		return

	_hit_flash_timer -= delta
	if _hit_flash_timer <= 0.0 and visual != null:
		visual.color = _base_color


func _update_facing_visual() -> void:
	if visual == null:
		return

	visual.scale.x = float(facing_direction)


func _update_health_label() -> void:
	if health_label == null:
		return

	health_label.text = "%s/%s" % [current_health, max_health]
