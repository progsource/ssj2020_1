extends Area2D

func _ready():
	add_to_group("item")
	# warning-ignore:return_value_discarded
	EventBus.connect("item_picked_up", self, "_on_item_picked_up")
	connect("body_entered", self, "_on_body_entered")

func _on_item_picked_up(sender_id) -> void:
	if get_instance_id() == sender_id:
		queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		EventBus.emit_signal("item_picked_up", get_instance_id())
