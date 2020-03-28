extends CanvasLayer

onready var animation_player := $AnimationPlayer

export(float, 0.5, 1.0, 0.1) var delay = 0.5

func _ready() -> void:
	EventBus.connect("objective_completed", self, "_on_objective_completed")

func _on_objective_completed(_sender_id, path) -> void:
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	EventBus.emit_signal("scene_changed", get_instance_id())
