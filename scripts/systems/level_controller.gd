extends Node2D
class_name LevelController

## Minimal playable level controller.
## Tracks enemy clear condition, displays the current objective, and supports restart after victory.
## Later this can become a proper run/room state machine.

@onready var objective_label: Label = $HUD/ObjectiveLabel

var is_victory: bool = false


func _ready() -> void:
	_update_objective_label()


func _process(delta: float) -> void:
	if is_victory:
		if Input.is_physical_key_pressed(KEY_R):
			get_tree().reload_current_scene()
		return

	if _is_player_dead():
		_update_objective_label()
		return

	var remaining_enemies := _count_alive_enemies()
	if remaining_enemies <= 0:
		_trigger_victory()
	else:
		_update_objective_label(remaining_enemies)


func _count_alive_enemies() -> int:
	var count := 0

	for enemy in get_tree().get_nodes_in_group("enemies"):
		if not is_instance_valid(enemy):
			continue

		if enemy.get("is_dead") == true:
			continue

		count += 1

	return count


func _is_player_dead() -> bool:
	var players := get_tree().get_nodes_in_group("player")
	if players.is_empty():
		return false

	var player := players[0]
	return player.get("is_dead") == true


func _trigger_victory() -> void:
	is_victory = true
	if objective_label != null:
		objective_label.text = "VICTORY! All monsters defeated. Press R to restart."


func _update_objective_label(remaining_enemies: int = -1) -> void:
	if objective_label == null:
		return

	if _is_player_dead():
		objective_label.text = "DEFEATED. Press R to restart."
		return

	if remaining_enemies < 0:
		remaining_enemies = _count_alive_enemies()

	objective_label.text = "Objective: Defeat all monsters | Remaining: %s" % remaining_enemies
