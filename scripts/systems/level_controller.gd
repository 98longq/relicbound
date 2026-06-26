extends Node2D
class_name LevelController

## Playable level controller.
## Tracks enemy clear condition, displays objective/player/boss status, and supports restart after victory or defeat.

@onready var hud: CanvasLayer = $HUD
@onready var objective_label: Label = $HUD/ObjectiveLabel
@onready var player_info_label: Label = $HUD/PlayerInfoLabel
@onready var boss_panel: ColorRect = $HUD/BossPanel
@onready var boss_label: Label = $HUD/BossLabel
@onready var boss_health_bar: ProgressBar = $HUD/BossHealthBar
@onready var result_panel: ColorRect = $HUD/ResultPanel
@onready var result_label: Label = $HUD/ResultLabel

var player_health_bar: ProgressBar
var is_victory: bool = false
var is_defeat: bool = false


func _ready() -> void:
	player_health_bar = get_node_or_null("HUD/PlayerHealthBar") as ProgressBar
	if player_health_bar == null:
		_create_player_health_bar()

	_apply_health_bar_styles()
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


func _create_player_health_bar() -> void:
	if hud == null:
		return

	player_health_bar = ProgressBar.new()
	player_health_bar.name = "PlayerHealthBar"
	player_health_bar.offset_left = 24.0
	player_health_bar.offset_top = 76.0
	player_health_bar.offset_right = 300.0
	player_health_bar.offset_bottom = 94.0
	player_health_bar.min_value = 0.0
	player_health_bar.max_value = 100.0
	player_health_bar.value = 100.0
	player_health_bar.show_percentage = false
	hud.add_child(player_health_bar)


func _apply_health_bar_styles() -> void:
	_set_progress_bar_style(
		player_health_bar,
		Color(0.86, 0.08, 0.08, 1.0),
		Color(0.08, 0.015, 0.018, 0.95),
		Color(0.95, 0.38, 0.26, 1.0)
	)
	_set_progress_bar_style(
		boss_health_bar,
		Color(0.78, 0.04, 0.055, 1.0),
		Color(0.075, 0.012, 0.02, 0.95),
		Color(0.95, 0.30, 0.22, 1.0)
	)


func _set_progress_bar_style(bar: ProgressBar, fill_color: Color, background_color: Color, border_color: Color) -> void:
	if bar == null:
		return

	var background := StyleBoxFlat.new()
	background.bg_color = background_color
	background.border_color = border_color
	background.border_width_left = 1
	background.border_width_top = 1
	background.border_width_right = 1
	background.border_width_bottom = 1
	background.corner_radius_top_left = 4
	background.corner_radius_top_right = 4
	background.corner_radius_bottom_left = 4
	background.corner_radius_bottom_right = 4

	var fill := StyleBoxFlat.new()
	fill.bg_color = fill_color
	fill.corner_radius_top_left = 4
	fill.corner_radius_top_right = 4
	fill.corner_radius_bottom_left = 4
	fill.corner_radius_bottom_right = 4

	bar.add_theme_stylebox_override("background", background)
	bar.add_theme_stylebox_override("fill", fill)


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
	_show_result("胜利", _build_result_summary("所有敌人已击败"))


func _trigger_defeat() -> void:
	is_defeat = true
	if objective_label != null:
		objective_label.text = "失败！按 R 重新开始。"
	_show_result("失败", _build_result_summary("角色已倒下"))


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
		if player_health_bar != null:
			player_health_bar.value = 0.0
		return

	var current_health = player.get("current_health")
	var max_health = player.get("max_health")
	var gold = player.get("gold")
	player_info_label.text = "生命：%s/%s | 金币：%s" % [current_health, max_health, gold]

	if player_health_bar != null:
		player_health_bar.max_value = float(max_health)
		player_health_bar.value = float(current_health)


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
	var boss_name := "遗迹守卫"
	if boss.get("is_phase_two") == true:
		boss_name = "遗迹守卫·狂暴"

	if boss_label != null:
		boss_label.text = "%s：%s/%s" % [boss_name, current_health, max_health]

	if boss_health_bar != null:
		boss_health_bar.max_value = float(max_health)
		boss_health_bar.value = float(current_health)


func _build_result_summary(reason: String) -> String:
	var player := _get_player()
	var gold := 0
	var current_health := 0
	var max_health := 0

	if player != null:
		gold = int(player.get("gold"))
		current_health = int(player.get("current_health"))
		max_health = int(player.get("max_health"))

	return "%s\n金币：%s\n生命：%s/%s\n按 R 重新开始" % [reason, gold, current_health, max_health]


func _show_result(title: String, body: String) -> void:
	_set_result_visible(true)

	if result_panel != null:
		result_panel.offset_top = 210.0
		result_panel.offset_bottom = 420.0

	if result_label != null:
		result_label.offset_top = 232.0
		result_label.offset_bottom = 395.0
		result_label.text = "%s\n%s" % [title, body]


func _set_result_visible(is_visible: bool) -> void:
	if result_panel != null:
		result_panel.visible = is_visible
	if result_label != null:
		result_label.visible = is_visible
