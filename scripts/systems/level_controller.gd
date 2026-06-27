extends Node2D
class_name LevelController

## Playable level controller.
## Tracks enemy clear condition, displays objective/player/boss status, opens the exit portal, and supports restart after victory or defeat.

@export_group("Exit Portal")
@export var exit_portal_position: Vector2 = Vector2(3150, 560)
@export var exit_portal_size: Vector2 = Vector2(82, 118)

@onready var hud: CanvasLayer = $HUD
@onready var top_panel: ColorRect = $HUD/Panel
@onready var objective_label: Label = $HUD/ObjectiveLabel
@onready var player_info_label: Label = $HUD/PlayerInfoLabel
@onready var controls_label: Label = $HUD/ControlsLabel
@onready var boss_panel: ColorRect = $HUD/BossPanel
@onready var boss_label: Label = $HUD/BossLabel
@onready var boss_health_bar: ProgressBar = $HUD/BossHealthBar
@onready var result_panel: ColorRect = $HUD/ResultPanel
@onready var result_label: Label = $HUD/ResultLabel

var player_health_bar: ProgressBar
var start_panel: ColorRect
var start_label: Label
var exit_portal_area: Area2D
var exit_portal_visual_root: Node2D
var exit_portal_glow: Polygon2D
var exit_portal_core: Polygon2D
var exit_portal_ring: Line2D
var exit_portal_inner_ring: Line2D
var exit_portal_label: Label
var exit_portal_runes: Array[Label] = []
var exit_portal_particles: Array[ColorRect] = []
var is_game_started: bool = false
var is_exit_portal_open: bool = false
var is_victory: bool = false
var is_defeat: bool = false


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	player_health_bar = get_node_or_null("HUD/PlayerHealthBar") as ProgressBar
	if player_health_bar == null:
		_create_player_health_bar()

	_create_exit_portal()
	_create_start_menu()
	_layout_hud()
	_apply_health_bar_styles()
	_set_result_visible(false)
	_update_objective_label()
	_update_player_info_label()
	_update_boss_health_bar()

	get_tree().paused = true


func _process(delta: float) -> void:
	if not is_game_started:
		_update_start_menu_visual()
		if _is_start_pressed():
			_start_game()
		return

	_update_player_info_label()
	_update_boss_health_bar()
	_update_exit_portal_visual(delta)

	if is_victory or is_defeat:
		if Input.is_physical_key_pressed(KEY_R):
			get_tree().reload_current_scene()
		return

	if _is_player_dead():
		_trigger_defeat()
		return

	var remaining_enemies := _count_alive_enemies()
	if remaining_enemies <= 0:
		_open_exit_portal()
		_update_portal_objective_label()
	else:
		_update_objective_label(remaining_enemies)


func _create_player_health_bar() -> void:
	if hud == null:
		return

	player_health_bar = ProgressBar.new()
	player_health_bar.name = "PlayerHealthBar"
	player_health_bar.min_value = 0.0
	player_health_bar.max_value = 100.0
	player_health_bar.value = 100.0
	player_health_bar.show_percentage = false
	hud.add_child(player_health_bar)

	# Draw the bar behind the HP text label.
	if player_info_label != null:
		hud.move_child(player_health_bar, player_info_label.get_index())


func _create_start_menu() -> void:
	if hud == null:
		return

	var viewport_size := get_viewport_rect().size

	start_panel = ColorRect.new()
	start_panel.name = "StartPanel"
	start_panel.offset_left = 0.0
	start_panel.offset_top = 0.0
	start_panel.offset_right = viewport_size.x
	start_panel.offset_bottom = viewport_size.y
	start_panel.color = Color(0.018, 0.012, 0.028, 0.92)
	hud.add_child(start_panel)

	start_label = Label.new()
	start_label.name = "StartLabel"
	start_label.offset_left = viewport_size.x * 0.5 - 330.0
	start_label.offset_top = viewport_size.y * 0.5 - 145.0
	start_label.offset_right = viewport_size.x * 0.5 + 330.0
	start_label.offset_bottom = viewport_size.y * 0.5 + 145.0
	start_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	start_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	start_label.text = "遗物之契\n\n击败遗迹守卫，开启终点传送门\n收集金币与补给，完成本关试炼\n\n按 Enter 开始"
	start_label.add_theme_font_size_override("font_size", 24)
	start_label.add_theme_color_override("font_color", Color(1.0, 0.88, 0.68, 1.0))
	start_label.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 1.0))
	start_label.add_theme_constant_override("outline_size", 3)
	hud.add_child(start_label)


func _create_exit_portal() -> void:
	exit_portal_area = Area2D.new()
	exit_portal_area.name = "ExitPortal"
	exit_portal_area.position = exit_portal_position
	exit_portal_area.collision_layer = 0
	exit_portal_area.collision_mask = 2
	exit_portal_area.monitoring = false
	exit_portal_area.monitorable = false
	exit_portal_area.visible = false
	add_child(exit_portal_area)

	var collision_shape := CollisionShape2D.new()
	var rectangle_shape := RectangleShape2D.new()
	rectangle_shape.size = exit_portal_size
	collision_shape.shape = rectangle_shape
	exit_portal_area.add_child(collision_shape)

	exit_portal_visual_root = Node2D.new()
	exit_portal_visual_root.name = "PortalVisual"
	exit_portal_visual_root.position = Vector2(0.0, -exit_portal_size.y * 0.5)
	exit_portal_area.add_child(exit_portal_visual_root)

	exit_portal_glow = Polygon2D.new()
	exit_portal_glow.name = "Glow"
	exit_portal_glow.polygon = _make_ellipse_points(58.0, 82.0, 48)
	exit_portal_glow.color = Color(0.55, 0.10, 1.0, 0.24)
	exit_portal_visual_root.add_child(exit_portal_glow)

	exit_portal_core = Polygon2D.new()
	exit_portal_core.name = "Core"
	exit_portal_core.polygon = _make_ellipse_points(32.0, 62.0, 48)
	exit_portal_core.color = Color(0.35, 0.04, 0.92, 0.78)
	exit_portal_visual_root.add_child(exit_portal_core)

	exit_portal_ring = _create_portal_ring("OuterRing", 42.0, 72.0, 5.0, Color(0.92, 0.66, 1.0, 0.95))
	exit_portal_visual_root.add_child(exit_portal_ring)

	exit_portal_inner_ring = _create_portal_ring("InnerRing", 27.0, 55.0, 2.0, Color(0.52, 0.88, 1.0, 0.82))
	exit_portal_visual_root.add_child(exit_portal_inner_ring)

	_create_exit_portal_runes()
	_create_exit_portal_particles()

	exit_portal_label = Label.new()
	exit_portal_label.name = "Label"
	exit_portal_label.offset_left = -110.0
	exit_portal_label.offset_top = -158.0
	exit_portal_label.offset_right = 110.0
	exit_portal_label.offset_bottom = -126.0
	exit_portal_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	exit_portal_label.text = "传送门已开启"
	exit_portal_label.add_theme_color_override("font_color", Color(0.94, 0.82, 1.0, 1.0))
	exit_portal_label.add_theme_color_override("font_outline_color", Color(0.05, 0.0, 0.12, 1.0))
	exit_portal_label.add_theme_constant_override("outline_size", 2)
	exit_portal_area.add_child(exit_portal_label)

	exit_portal_area.body_entered.connect(_on_exit_portal_body_entered)


func _create_portal_ring(name: String, radius_x: float, radius_y: float, width: float, color: Color) -> Line2D:
	var ring := Line2D.new()
	ring.name = name
	ring.points = _make_ellipse_points(radius_x, radius_y, 64)
	ring.width = width
	ring.closed = true
	ring.default_color = color
	return ring


func _create_exit_portal_runes() -> void:
	var rune_data := [
		["◆", Vector2(0.0, -88.0)],
		["◆", Vector2(0.0, 72.0)],
		["✦", Vector2(-56.0, -18.0)],
		["✦", Vector2(56.0, -18.0)]
	]

	for data in rune_data:
		var rune := Label.new()
		rune.text = data[0]
		rune.position = data[1]
		rune.size = Vector2(28.0, 28.0)
		rune.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		rune.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		rune.add_theme_color_override("font_color", Color(0.95, 0.78, 1.0, 0.95))
		rune.add_theme_color_override("font_outline_color", Color(0.10, 0.0, 0.18, 1.0))
		rune.add_theme_constant_override("outline_size", 2)
		exit_portal_visual_root.add_child(rune)
		exit_portal_runes.append(rune)


func _create_exit_portal_particles() -> void:
	for index in range(10):
		var particle := ColorRect.new()
		particle.name = "Particle%s" % index
		particle.offset_left = -2.0
		particle.offset_top = -2.0
		particle.offset_right = 2.0
		particle.offset_bottom = 2.0
		particle.color = Color(0.86, 0.64, 1.0, 0.70)
		exit_portal_visual_root.add_child(particle)
		exit_portal_particles.append(particle)


func _make_ellipse_points(radius_x: float, radius_y: float, point_count: int) -> PackedVector2Array:
	var points := PackedVector2Array()
	for index in range(point_count):
		var angle := (float(index) / float(point_count)) * PI * 2.0
		points.append(Vector2(cos(angle) * radius_x, sin(angle) * radius_y))
	return points


func _layout_hud() -> void:
	_layout_player_hud()
	_layout_boss_hud()


func _layout_player_hud() -> void:
	if top_panel != null:
		top_panel.offset_left = 14.0
		top_panel.offset_top = 14.0
		top_panel.offset_right = 1010.0
		top_panel.offset_bottom = 118.0

	if objective_label != null:
		objective_label.offset_left = 24.0
		objective_label.offset_top = 22.0
		objective_label.offset_right = 850.0
		objective_label.offset_bottom = 48.0

	if player_health_bar != null:
		player_health_bar.offset_left = 24.0
		player_health_bar.offset_top = 54.0
		player_health_bar.offset_right = 304.0
		player_health_bar.offset_bottom = 78.0

	if player_info_label != null:
		player_info_label.offset_left = 24.0
		player_info_label.offset_top = 54.0
		player_info_label.offset_right = 304.0
		player_info_label.offset_bottom = 78.0
		player_info_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		player_info_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		player_info_label.add_theme_color_override("font_color", Color(1.0, 0.92, 0.88, 1.0))
		player_info_label.add_theme_color_override("font_outline_color", Color(0.05, 0.0, 0.0, 1.0))
		player_info_label.add_theme_constant_override("outline_size", 2)

	if controls_label != null:
		controls_label.offset_left = 24.0
		controls_label.offset_top = 86.0
		controls_label.offset_right = 990.0
		controls_label.offset_bottom = 112.0


func _layout_boss_hud() -> void:
	var viewport_width := get_viewport_rect().size.x
	var panel_width := 560.0
	var panel_left := (viewport_width - panel_width) * 0.5
	var panel_right := panel_left + panel_width

	if boss_panel != null:
		boss_panel.offset_left = panel_left
		boss_panel.offset_top = 128.0
		boss_panel.offset_right = panel_right
		boss_panel.offset_bottom = 184.0

	if boss_label != null:
		boss_label.offset_left = panel_left + 16.0
		boss_label.offset_top = 134.0
		boss_label.offset_right = panel_right - 16.0
		boss_label.offset_bottom = 158.0
		boss_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	if boss_health_bar != null:
		boss_health_bar.offset_left = panel_left + 22.0
		boss_health_bar.offset_top = 160.0
		boss_health_bar.offset_right = panel_right - 22.0
		boss_health_bar.offset_bottom = 178.0


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


func _get_player_gold() -> int:
	var player := _get_player()
	if player == null:
		return 0

	return int(player.get("gold"))


func _is_start_pressed() -> bool:
	return Input.is_key_pressed(KEY_ENTER) or Input.is_key_pressed(KEY_KP_ENTER)


func _start_game() -> void:
	is_game_started = true
	get_tree().paused = false
	if start_panel != null:
		start_panel.visible = false
	if start_label != null:
		start_label.visible = false


func _update_start_menu_visual() -> void:
	if start_label == null:
		return

	var pulse := 0.82 + 0.18 * sin(Time.get_ticks_msec() / 320.0)
	start_label.modulate = Color(1.0, 1.0, 1.0, pulse)


func _open_exit_portal() -> void:
	if is_exit_portal_open:
		return

	is_exit_portal_open = true
	if exit_portal_area != null:
		exit_portal_area.visible = true
		exit_portal_area.monitoring = true


func _update_exit_portal_visual(_delta: float) -> void:
	if not is_exit_portal_open or exit_portal_visual_root == null:
		return

	var time := Time.get_ticks_msec() / 1000.0
	var pulse := 0.92 + 0.08 * sin(time * 4.0)
	exit_portal_visual_root.scale = Vector2(0.96 + 0.04 * pulse, 1.0 + 0.05 * sin(time * 3.2))

	if exit_portal_glow != null:
		exit_portal_glow.color = Color(0.62, 0.14, 1.0, 0.22 + 0.10 * pulse)
	if exit_portal_core != null:
		exit_portal_core.color = Color(0.31, 0.04, 0.92, 0.70 + 0.10 * pulse)
	if exit_portal_ring != null:
		exit_portal_ring.default_color = Color(0.98, 0.75, 1.0, 0.84 + 0.12 * pulse)
		exit_portal_ring.rotation = sin(time * 1.8) * 0.035
	if exit_portal_inner_ring != null:
		exit_portal_inner_ring.default_color = Color(0.48, 0.88, 1.0, 0.72 + 0.16 * pulse)
		exit_portal_inner_ring.rotation = -sin(time * 2.2) * 0.055

	for index in range(exit_portal_particles.size()):
		var particle := exit_portal_particles[index]
		var angle := time * 1.15 + float(index) * PI * 2.0 / float(exit_portal_particles.size())
		var radius_x := 48.0 + 8.0 * sin(time * 1.7 + float(index))
		var radius_y := 70.0 + 6.0 * cos(time * 1.3 + float(index))
		var particle_position := Vector2(cos(angle) * radius_x, sin(angle) * radius_y)
		particle.offset_left = particle_position.x - 2.0
		particle.offset_top = particle_position.y - 2.0
		particle.offset_right = particle_position.x + 2.0
		particle.offset_bottom = particle_position.y + 2.0
		particle.color = Color(0.92, 0.72, 1.0, 0.42 + 0.26 * sin(time * 2.0 + float(index)))

	for index in range(exit_portal_runes.size()):
		var rune := exit_portal_runes[index]
		rune.modulate = Color(1.0, 1.0, 1.0, 0.70 + 0.22 * sin(time * 2.5 + float(index)))


func _update_portal_objective_label() -> void:
	if objective_label == null:
		return

	objective_label.text = "传送门已开启 | 进入传送门完成关卡 | 金币：%s" % _get_player_gold()


func _on_exit_portal_body_entered(body: Node) -> void:
	if not is_exit_portal_open or is_victory or is_defeat:
		return

	if not body.is_in_group("player"):
		return

	_trigger_victory()


func _trigger_victory() -> void:
	is_victory = true
	if exit_portal_area != null:
		exit_portal_area.monitoring = false
	if objective_label != null:
		objective_label.text = "胜利！已进入传送门 | 金币：%s | 按 R 重新开始。" % _get_player_gold()
	_show_result("胜利", _build_result_summary("已进入传送门"))


func _trigger_defeat() -> void:
	is_defeat = true
	if objective_label != null:
		objective_label.text = "失败！金币：%s | 按 R 重新开始。" % _get_player_gold()
	_show_result("失败", _build_result_summary("角色已倒下"))


func _update_objective_label(remaining_enemies: int = -1) -> void:
	if objective_label == null:
		return

	if _is_player_dead():
		objective_label.text = "失败！金币：%s | 按 R 重新开始。" % _get_player_gold()
		return

	if remaining_enemies < 0:
		remaining_enemies = _count_alive_enemies()

	objective_label.text = "目标：击败全部敌人 | 剩余：%s | 金币：%s" % [remaining_enemies, _get_player_gold()]


func _update_player_info_label() -> void:
	if player_info_label == null:
		return

	var player := _get_player()
	if player == null:
		player_info_label.text = "生命：--/--"
		if player_health_bar != null:
			player_health_bar.value = 0.0
		return

	var current_health = player.get("current_health")
	var max_health = player.get("max_health")
	player_info_label.text = "生命：%s/%s" % [current_health, max_health]

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
