extends Control
class_name MainMenu

const TEST_LEVEL_PATH := "res://scenes/levels/test_level.tscn"
const NEXT_LEVEL_PLACEHOLDER_PATH := "res://scenes/levels/next_level_placeholder.tscn"

@onready var start_button: Button = $MenuPanel/StartButton
@onready var next_preview_button: Button = $MenuPanel/NextPreviewButton
@onready var quit_button: Button = $MenuPanel/QuitButton
@onready var hint_label: Label = $MenuPanel/HintLabel


func _ready() -> void:
	get_tree().paused = false

	if start_button != null:
		start_button.pressed.connect(_start_game)
		start_button.grab_focus()

	if next_preview_button != null:
		next_preview_button.pressed.connect(_open_next_preview)

	if quit_button != null:
		quit_button.pressed.connect(_quit_game)


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ENTER) or Input.is_key_pressed(KEY_KP_ENTER):
		_start_game()

	if hint_label != null:
		var pulse := 0.82 + 0.18 * sin(Time.get_ticks_msec() / 320.0)
		hint_label.modulate = Color(1.0, 1.0, 1.0, pulse)


func _start_game() -> void:
	get_tree().change_scene_to_file(TEST_LEVEL_PATH)


func _open_next_preview() -> void:
	get_tree().change_scene_to_file(NEXT_LEVEL_PLACEHOLDER_PATH)


func _quit_game() -> void:
	get_tree().quit()
