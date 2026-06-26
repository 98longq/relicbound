extends Node2D
class_name LevelController

## Playable level controller.
## Tracks enemy clear condition, displays objective/player/boss status, and supports restart after victory or defeat.

@onready var objective_label: Label = $HUD/ObjectiveLabel
@onready var player_info_label: Label = $HUD/PlayerInfoLabel
@onready var boss_panel: ColorRect = $HUD/BossPanel
@onready var boss_label: Label = $HUD/BossLabel
@onready var boss_health_bar: ProgressBar = $HUD/BossHealthBar
@onready var result_panel: ColorRect = $HUD/ResultPanel
@onready var result_label: Label = $HUD/ResultLabel

var is_victory: bool = false
var is_defeat: bool = false


func _ready() -> void:
	_set_result_visible(false)
	_update_objective_label()
	_update_player_info_label()
	_update_boss_health_bar()


func _process(_delta: float) -> void:
	_update_player_info_label()
	_update_boss_health_bar()

	if is_victory or is_defeat:
		if Input.is_physical_key_pressed(KEY_R):
			get_tree().reload_current_scene()
		return

	if _is_player_dead():
		_trigger_defeat()
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


func _get_player() -> Node:
	var players := get_tree().get_nodes_in_group("player")
	if players.is_empty():
		return null

	return players[0]


func _get_boss() -> Node:
	var bosses := get_tree().get_nodes_in_group("bosses")
	for boss in bosses:
		if not is_instance_valid(boss):
			continue
		if boss.get("is_dead") == true:
			continue
		return boss

	return null


func _is_player_dead() -> bool:
	var player := _get_player()
	if player == null:
		return false

	return player.get("is_dead") == true


func _trigger_victory() -> void:
	is_victory = true
	if objective_label != null:
		objective_label.text = "胜利！所有敌人已击败，按 R 重新开始。"
	_show_result("胜利", "所有敌人已击败\n按 R 重新开始")


func _trigger_defeat() -> void:
	is_defeat = true
	if objective_label != null:
		objective_label.text = "失败！按 R 重新开始。"
	_show_result("失败", "角色已倒下\n按 R 重新开始")


func _update_objective_label(remaining_enemies: int = -1) -> void:
	if objective_label == null:
		return

	if _is_player_dead():
		objective_label.text = "失败！按 R 重新开始。"
		return

	if remaining_enemies < 0:
		remaining_enemies = _count_alive_enemies()

	objective_label.text = "目标：击败全部敌人 | 剩余：%s" % remaining_enemies


func _update_player_info_label() -> void:
	if player_info_label == null:
		return

	var player := _get_player()
	if player == null:
		player_info_label.text = "生命：-- | 金币：--"
		return

	var current_health = player.get("current_health")
	var max_health = player.get("max_health")
	var gold = player.get("gold")
	player_info_label.text = "生命：%s/%s | 金币：%s" % [current_health, max_health, gold]


func _update_boss_health_bar() -> void:
	var boss := _get_boss()
	var has_boss := boss != null

	if boss_panel != null:
		boss_panel.visible = has_boss
	if boss_label != null:
		boss_label.visible = has_boss
	if boss_health_bar != null:
		boss_health_bar.visible = has_boss

	if not has_boss:
		return

	var current_health = boss.get("current_health")
	var max_health = boss.get("max_health")

	if boss_label != null:
		boss_label.text = "遗迹守卫：%s/%s" % [current_health, max_health]

	if boss_health_bar != null:
		boss_health_bar.max_value = float(max_health)
		boss_health_bar.value = float(current_health)


func _show_result(title: String, body: String) -> void:
	_set_result_visible(true)
	if result_label != null:
		result_label.text = "%s\n%s" % [title, body]


func _set_result_visible(is_visible: bool) -> void:
	if result_panel != null:
		result_panel.visible = is_visible
	if result_label != null:
		result_label.visible = is_visible
