extends CanvasLayer


func _ready():
	# warning-ignore:return_value_discarded
	$Timer.connect("timeout", self, "_on_timer_timeout")


func _on_timer_timeout():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/GameStart.tscn")
