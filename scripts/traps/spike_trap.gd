extends Area2D
class_name SpikeTrap

@export var damage: int = 14
@export var damage_cooldown: float = 0.75

var _damage_timer: float = 0.0


func _physics_process(delta: float) -> void:
	_damage_timer = maxf(_damage_timer - delta, 0.0)
	if _damage_timer > 0.0:
		return

	for body in get_overlapping_bodies():
		if body.is_in_group("player") and body.has_method("apply_damage"):
			body.apply_damage(damage, self)
			_damage_timer = damage_cooldown
			return
