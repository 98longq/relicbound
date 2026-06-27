extends Control
class_name NextLevelPlaceholder

const MAIN_MENU_PATH := "res://scenes/ui/main_menu.tscn"
const TEST_LEVEL_PATH := "res://scenes/levels/test_level.tscn"

@onready var info_label: Label = $InfoLabel


func _ready() -> void:
	get_tree().paused = false


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ENTER) or Input.is_key_pressed(KEY_KP_ENTER):
		get_tree().change_scene_to_file(TEST_LEVEL_PATH)

	if Input.is_physical_key_pressed(KEY_ESCAPE) or Input.is_physical_key_pressed(KEY_R):
		get_tree().change_scene_to_file(MAIN_MENU_PATH)

	if info_label != null:
		var pulse := 0.84 + 0.16 * sin(Time.get_ticks_msec() / 360.0)
		info_label.modulate = Color(1.0, 1.0, 1.0, pulse)
