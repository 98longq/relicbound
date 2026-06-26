extends Label
class_name DamageNumber

@export var float_speed: float = 54.0
@export var lifetime: float = 0.65
@export var spread_x: float = 26.0

var _timer: float = 0.0
var _velocity: Vector2 = Vector2.ZERO


func setup(amount: int, is_critical: bool = false) -> void:
	text = "-%s" % amount
	_timer = lifetime
	_velocity = Vector2(randf_range(-spread_x, spread_x), -float_speed)
	if is_critical:
		text = "-%s!" % amount
		scale = Vector2(1.25, 1.25)
	else:
		scale = Vector2.ONE


func _ready() -> void:
	if _timer <= 0.0:
		_timer = lifetime


func _process(delta: float) -> void:
	_timer -= delta
	position += _velocity * delta
	_velocity.y -= 18.0 * delta

	var alpha := clampf(_timer / lifetime, 0.0, 1.0)
	modulate.a = alpha

	if _timer <= 0.0:
		queue_free()
