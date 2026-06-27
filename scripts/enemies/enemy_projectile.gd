extends Area2D
class_name EnemyProjectile

@export var speed: float = 360.0
@export var damage: int = 10
@export var lifetime: float = 2.8

var direction: Vector2 = Vector2.LEFT
var source: Node
var _timer: float = 0.0


func setup(spawn_direction: Vector2, source_node: Node = null) -> void:
	direction = spawn_direction.normalized()
	if direction.is_zero_approx():
		direction = Vector2.LEFT
	source = source_node


func _ready() -> void:
	_timer = lifetime
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	_timer -= delta
	global_position += direction * speed * delta

	if _timer <= 0.0:
		queue_free()


func _on_body_entered(body: Node) -> void:
	if body == source:
		return

	if body.is_in_group("player") and body.has_method("apply_damage"):
		body.apply_damage(damage, self)
		queue_free()
		return

	if not body.is_in_group("enemies"):
		queue_free()
