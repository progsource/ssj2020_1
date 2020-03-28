extends KinematicBody2D

export(String, FILE) var next_level_file_path := ""

func _get_configuration_warning() -> String:
	return "next_level_file_path is mandatory!" if next_level_file_path.empty() else ""

func _on_body_entered(body) -> void:
	EventBus.emit_signal("objective_completed", get_instance_id(), next_level_file_path)
