extends CanvasLayer


onready var animation_player := $AnimationPlayer


export(float, 0.5, 1.0, 0.1) var delay = 0.5


func _ready() -> void:
	# warning-ignore:return_value_discarded
	EventBus.connect("objective_completed", self, "_on_objective_completed")
	# warning-ignore:return_value_discarded
	EventBus.connect("infected", self, "_on_infected")


func _on_objective_completed(_sender_id, path) -> void :
	if get_tree().get_current_scene().has_node("Menu"):
		var menu = get_tree().get_current_scene().get_node("Menu")
		menu.set_visible(false)
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	EventBus.emit_signal("scene_changed", get_instance_id())


func _on_infected(_sender_id) -> void :
	_on_objective_completed(_sender_id, "res://scenes/GameOver.tscn")
