extends CharacterBody2D
class_name EnemyBase

## M2 enemy prototype.
## This script only covers health, receiving damage, basic gravity, hit feedback, and death.
## Enemy AI, attacks, loot drops, and elite modifiers belong to later milestones.

@export var max_health: int = 30
@export var gravity: float = 1600.0
@export var max_fall_speed: float = 900.0
@export var hit_flash_time: float = 0.08

@onready var visual: ColorRect = $Visual
@onready var health_label: Label = $HealthLabel

var current_health: int
var is_dead: bool = false
var _hit_flash_timer: float = 0.0
var _base_color: Color = Color(0.7, 0.18, 0.22, 1.0)


func _ready() -> void:
	current_health = max_health
	add_to_group("enemies")

	if visual != null:
		_base_color = visual.color

	_update_health_label()


func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_update_hit_flash(delta)
	move_and_slide()


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
	queue_free()


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


func _update_health_label() -> void:
	if health_label == null:
		return

	health_label.text = "%s/%s" % [current_health, max_health]
