extends Area2D
class_name PickupItem

## M3 pickup prototype.
## Supports simple body-touch pickup for gold and health.
## Inventory, item rarity, equipment, and pickup prompts belong to later milestones.

@export_enum("gold", "health") var pickup_type: String = "gold"
@export var amount: int = 1

@onready var label: Label = $Label


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	_update_label()


func _on_body_entered(body: Node) -> void:
	if body.has_method("collect_pickup"):
		body.collect_pickup(pickup_type, amount)
		queue_free()


func _update_label() -> void:
	if label == null:
		return

	match pickup_type:
		"gold":
			label.text = "+%s G" % amount
		"health":
			label.text = "+%s HP" % amount
		_:
			label.text = "+%s" % amount
