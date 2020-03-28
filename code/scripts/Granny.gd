extends Area2D

export(String, FILE) var next_level_file_path := ""

func _ready() -> void:
	# warning-ignore:return_value_discarded
	connect("body_entered", self, "_on_body_entered")

func _get_configuration_warning() -> String:
	return "next_level_file_path is mandatory!" if next_level_file_path.empty() else ""

func _on_body_entered(body) -> void:
	if body.name == "Player":
		EventBus.emit_signal("objective_completed", get_instance_id(), next_level_file_path)
