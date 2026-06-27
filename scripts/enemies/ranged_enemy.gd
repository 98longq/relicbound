extends EnemyBase
class_name RangedEnemy

const PROJECTILE_SCENE := preload("res://scenes/enemies/enemy_projectile.tscn")

@export_group("Ranged Combat")
@export var preferred_range: float = 290.0
@export var retreat_range: float = 150.0
@export var shoot_range: float = 560.0
@export var vertical_shoot_tolerance: float = 105.0
@export var shoot_cooldown: float = 1.35
@export var projectile_spawn_offset: Vector2 = Vector2(42, -34)


func _update_ai(delta: float) -> void:
	if _target == null or not is_instance_valid(_target):
		velocity.x = move_toward(velocity.x, 0.0, move_speed * 8.0 * delta)
		return

	var to_target := _target.global_position - global_position
	var horizontal_distance := absf(to_target.x)
	var vertical_distance := absf(to_target.y)
	var direction := 1.0 if to_target.x > 0.0 else -1.0
	facing_direction = 1 if direction > 0.0 else -1

	if horizontal_distance > detection_range or vertical_distance > 150.0:
		velocity.x = move_toward(velocity.x, 0.0, move_speed * 8.0 * delta)
		return

	if horizontal_distance < retreat_range:
		velocity.x = -direction * move_speed * 0.72
	elif horizontal_distance > preferred_range:
		velocity.x = direction * move_speed * 0.82
	else:
		velocity.x = move_toward(velocity.x, 0.0, move_speed * 6.0 * delta)

	if horizontal_distance <= shoot_range and vertical_distance <= vertical_shoot_tolerance:
		_try_shoot_projectile()


func _try_shoot_projectile() -> void:
	if _attack_cooldown_timer > 0.0:
		return

	if _target == null or not is_instance_valid(_target):
		return

	_start_attack_feedback()

	var projectile := PROJECTILE_SCENE.instantiate()
	if projectile == null:
		return

	get_parent().add_child(projectile)
	projectile.global_position = global_position + Vector2(projectile_spawn_offset.x * float(facing_direction), projectile_spawn_offset.y)

	if projectile.has_method("setup"):
		projectile.setup(Vector2(float(facing_direction), 0.0), self)

	_attack_cooldown_timer = shoot_cooldown
