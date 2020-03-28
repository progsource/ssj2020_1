extends Sprite


func _ready():
	# warning-ignore:return_value_discarded
	$VisibilityNotifier2D.connect("viewport_exited", self, "_on_screen_exit")


func _on_screen_exit():
	queue_free()
